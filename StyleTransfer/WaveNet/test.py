from hparams import hparams
import torch
from preprocessing import mu_law_expansion
import soundfile as sf
import glob
import numpy as np
import os
import librosa
from model import WavNet
from dataset import WavNet_Dataset
from tqdm import tqdm
# 输入 index  list  [N]
# 输出 onehot   [1,n_class,1]
def index2onehot(indexs,n_class):
    torch_indexs = torch.from_numpy(indexs).view(1,-1)
    data_one_hot = torch.zeros(n_class,len(indexs))
    data_one_hot.scatter_(0,torch_indexs, 1.)
    data_one_hot  = data_one_hot.unsqueeze(0).float()
    
    return data_one_hot
    
# model: Wavnet 模型
# init_data 初始化数据  [1,n_class,receptive_field]
def gen_wav(model,init_data,gen_length,temperature,n_class):
    
    out_gen = []
    
    for i in tqdm(range(gen_length)):
        in_wavnet = init_data[:,:,-receptive_field:]
        in_wavnet = in_wavnet.to(device)
        with torch.no_grad():
            x =  model(in_wavnet)
            
        x = x[0,:,0]
        if temperature > 0:
            x /= temperature
            prob = torch.softmax(x, dim=0)
            prob = prob.cpu().detach().numpy() 
        
            gen_sample = np.random.choice(n_class, p=prob)
            out_gen.append(gen_sample)
            
        else:
            x = torch.argmax(x)
            gen_sample = x.cpu().detach().numpy()
            out_gen.append(gen_sample)
            
        add_input = index2onehot(np.array([gen_sample]),n_class)
       
        init_data = torch.cat((init_data, add_input), 2)
        
    return out_gen
        
def coded2wav(coded,n_class):
    coded = (coded / n_class) * 2. - 1
    mu_gen = mu_law_expansion(coded, n_class)
    return mu_gen
    
    

if __name__ == "__main__":
    
     # 加载相关参数
    para = hparams()
    
    
    device = torch.device("cuda:0")
    
    # 加载模型
    n_model = 17
    model_name = os.path.join(para.path_save,str(n_model),'model.pick')
    m_model_all = torch.load(model_name)
    
    m_model = WavNet(para)
    m_model = m_model.to(device)
    
    receptive_field = m_model.receptive_field
    m_model.load_state_dict(m_model_all['model'])
    
    
    # 利用训练数据中随机的一段来生成音乐
    m_Dataset= WavNet_Dataset(para,receptive_field,para.output_length)
    temp_data = m_Dataset[20000][0]
    
    init_data = temp_data.unsqueeze(0)[:,:,-receptive_field:]
    
    # 概率最大输出
    time = 10 # 生成10秒的音乐
    out_gen = gen_wav(m_model,init_data,time*para.fs,0,para.classes)
    
    np.save('out.npy',out_gen)
    wav_gen = coded2wav(np.array(out_gen),para.classes)
    
    sf.write('gen_wav_t=0.wav',wav_gen,para.fs)
    
    
    # # 随机输出输出
    # time = 10 # 生成10秒的音乐
    # out_gen = gen_wav(m_model,init_data,time*para.fs,1,para.classes)
    
    # np.save('out.npy',out_gen)
    # wav_gen = coded2wav(np.array(out_gen),para.classes)
    
    # sf.write('gen_wav_t=1.wav',wav_gen,para.fs)
    
    # # 利用随机变量 生成
    
    # # 利用随机数生成音乐
    # init_indexes = [np.random.choice(para.classes) for i in range(receptive_field)]
    # init_data = index2onehot(np.array(init_indexes),para.classes)
 
    # time = 10 # 生成10秒的音乐
    # out_gen = gen_wav(m_model,init_data,time*para.fs,1,para.classes)
    
    # np.save('out.npy',out_gen)
    # wav_gen = coded2wav(np.array(out_gen),para.classes)
    
    # sf.write('gen_wav_t=1_random.wav',wav_gen,para.fs)
    
    
    
    
    
    
    
    
    
    
    