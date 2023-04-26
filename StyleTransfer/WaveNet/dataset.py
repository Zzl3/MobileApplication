import os
import torch
import numpy as np
import glob
from torch.utils.data import Dataset,DataLoader
from hparams import hparams

   
# receptive_field: 感受野
# output_length ：预测样本的数目
# 在训练过程中 利用             0-> receptive_field-1                 个样本 预测 第receptive_field个样本
#              利用             1-> receptive_field                   个样本 预测 第receptive_field+1个样本
#              利用             2-> receptive_field+1                 个样本 预测 第receptive_field+2个样本
#              。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
#              利用 output_length-1> receptive_field+output_length-2   个样本 预测 第receptive_field+output_length-1 个样本    
#
# 所以将语音分割成长度为  receptive_field+output_length 的小段 (index: 0->receptive_field+output_length-1)
# 其中 index：0->receptive_field+output_length-2  即前 receptive_field+output_length-1 个样本 作为 wavnet的输入
#      index: receptive_field ->receptive_field+output_length-1 个样作为目标， 即后output_length个样本

class WavNet_Dataset(Dataset):
    def __init__(self,para,receptive_field,output_length):
        
        self.receptive_field = receptive_field
        self.output_length = output_length
        self.item_length = receptive_field+output_length
        
        # self.file_wavs = para. 
        self.samples = []
        self.segments_index = []
        self.collect_segment_index(para.path_train_coded)
        self.classes = para.classes
        
    # 生成训练用的语音段
    def collect_segment_index(self,path_train_coded):
        
        files = glob.glob(path_train_coded+'/*npy')
        for file in files:
            sample = np.load(file)
            self.samples.append(sample)
            
        for i, sample in enumerate(self.samples):
            lenth_sample = len(sample)
            N_seg =  (lenth_sample - self.item_length)//self.output_length
            
            for k in range(N_seg):
                pos_start = k*self.output_length
                pos_end = pos_start + self.item_length
                
                if pos_end<lenth_sample:
                    self.segments_index.append((i,pos_start,pos_end))
            self.segments_index.append((i,lenth_sample-self.item_length,lenth_sample))
            
    def __len__(self):
        return len(self.segments_index)
    
    
    def __getitem__(self,idx):
        n_sample, pos_start, pos_end = self.segments_index[idx]
        
        train_data = self.samples[n_sample][pos_start:pos_end]
        
        train_net = train_data[:-1]
        
        train_net = torch.from_numpy(train_net)
        
        
        index = train_net.view(1,-1)
        train_one_hot = torch.zeros(self.classes,self.item_length-1)
        train_one_hot.scatter_(0,index, 1.)
        
        
        train_target = train_data[-self.output_length:]
        train_target = torch.from_numpy(train_target)

        return train_one_hot,train_target
        
        
if __name__ == "__main__":

    para = hparams()
    m_Dataset= WavNet_Dataset(para,receptive_field = 100,output_length=10)
    
    m_DataLoader = DataLoader(m_Dataset,batch_size = 32,shuffle = True, num_workers = 8)
    
    for n_epoch in range(3):
        
        for i_batch, sample_batch in enumerate(m_DataLoader):
            train_data = sample_batch[0]
            train_target = sample_batch[1]
            
            print(train_data.shape)
            print(train_target.shape)
    
        
            
            
        
                    
            
            
            
         
            
            
            
            
        
        
        
        
        
        








# class VC_StarGan_Dataset(Dataset):
    
    # def __init__(self,para):
        # self.para = para
        
        # # 获取说话人列表
        # self.spk_list = para.spk_list
        
        # # 加载全部数据
        # self.feas_all,self.labs_all = self.load_data_all()
        # self.n_files = len(self.feas_all)
        
        
        # # 获取说话人的数目
        # self.n_spk = len(self.spk_list)
        
        # # 构建spk 与 spk_id 之间的联系
        # self.spk2index = {}
        # self.index2spk = {}
        # self.spk2one_hot = {}
        # temp = torch.eye(self.n_spk)
        # for i,spk in  enumerate (self.para.spk_list):
            # self.spk2index[spk] = i
            # self.index2spk[i] = spk
            # self.spk2one_hot[spk] = temp[i]
        
        # # 训练用的特征对
        # self.pairs = []
        # self.gen_random_pair()

   
    # def load_data_all(self):
        # feas_all = []
        # labs_all = []
        # for spk in self.spk_list:
            # file_npy = os.path.join(self.para.path_catch_feas,spk,'data.npy')
            # feas = np.load(file_npy,allow_pickle=True).tolist()
            # labs = [spk]*len(feas)
            
            # feas_all = feas_all+feas
            # labs_all = labs_all+labs
        # return feas_all, labs_all
        
    
   

    # def gen_random_pair(self):
        
        # # 数据乱序
        # index = [i for i in range(self.n_files)]
        # np.random.shuffle(index)
        # self.pairs = []
        # for i in index:
            # fea_A = self.feas_all[i]
            # spk_A = self.labs_all[i]
            
            # # 去掉 spk_A 在其余的spk中选取 spk_B
            # self.spk_list.remove(spk_A)
            # spk_B = np.random.choice(self.spk_list)
            # self.spk_list.append(spk_A)
            
            # # 从spk_B的特征里面随机选取一个
            # index_spk_B = np.where(np.array(self.labs_all)==spk_B)[0].tolist()
            # i_sel_spk_B = np.random.choice(index_spk_B)
            # fea_B = self.feas_all[i_sel_spk_B]
            
            # self.pairs.append(tuple([fea_A, spk_A,fea_B, spk_B]))
        
    # def __len__(self):
        # return len(self.pairs)
        
        
    # def __getitem__(self,idx):
        
        # fea_A, spk_A, fea_B, spk_B = self.pairs[idx]
        
        # #  数据帧长 能够被4整除
       
        # len_A = np.shape(fea_A)[0]
        # len_A = int(len_A//4*4)
        # fea_A = fea_A[:len_A]
        # fea_A =  torch.from_numpy(fea_A.T)
        # fea_A = fea_A.unsqueeze(0)

        # len_B = np.shape(fea_B)[0]
        # len_B = int(len_B//4*4)
        # fea_B = fea_B[:len_B]
        # fea_B = torch.from_numpy(fea_B.T)
        # fea_B = fea_B.unsqueeze(0)
     
        # return fea_A, self.spk2one_hot[spk_A], self.spk2index[spk_A], \
               # fea_B, self.spk2one_hot[spk_B], self.spk2index[spk_B]
        
        
# if __name__ == "__main__":
    
    # para = hparams()
    # m_Dataset= VC_StarGan_Dataset(para)
    
    # m_DataLoader = DataLoader(m_Dataset,batch_size = 1,shuffle = True, num_workers = 1)
    
    # m_Dataset.gen_random_pair()
    # for n_epoch in range(3):
        # for i_batch, sample_batch in enumerate(m_DataLoader):
            # train_A = sample_batch[0]
            # index_A = sample_batch[1]
            # one_hot_A = sample_batch[2]
            
            
            # train_B = sample_batch[3]
            # index_B = sample_batch[4]
            # one_hot_B = sample_batch[5]
            # lab_B = sample_batch[3]
            # print(train_A.shape)
            # print(index_A)
            # print(one_hot_A)
            # print(train_B.shape)
            # print(index_B)
            # print(one_hot_B)
            
            
            # if i_batch>5:
                # break
            
        # m_Dataset.gen_random_pair()
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
