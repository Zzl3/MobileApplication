import torch.nn as nn
import torch
import numpy as np
import torch.nn.functional as F
from hparams import hparams
from dataset import WavNet_Dataset
from torch.utils.data import Dataset,DataLoader
from model import WavNet
import logging
import os
def adjust_lr_rate(optimizer,lr,lr_decay):
    lr_new = max(0.00005, lr - lr_decay)
   
    for param_groups in optimizer.param_groups:
        param_groups['lr'] = lr_new
    return lr_new,optimizer
    

if __name__ == "__main__":
    
     # 定义log文件
    file_log = "WaveNet.log"
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(file_log),
            logging.StreamHandler()
        ]
    )
    logger = logging.getLogger() 

    # 定义device
    device = torch.device("cuda:0")
    
    # 获取模型参数
    para = hparams()
    
    # 模型实例化
    m_model = WavNet(para)
    m_model = m_model.to(device)
    receptive_field = m_model.receptive_field
    # 定义优化器
    m_optimizer = torch.optim.Adam(m_model.parameters(), para.lr, [0.5, 0.999])
    lr = para.lr
    # # 模型加载
    # model_name = 'save/10/model.pick'
    # m_model_all = torch.load(model_name)
    # m_model.load_state_dict(m_model_all['model'])
    # m_optimizer.load_state_dict(m_model_all['opt'])
    
    
    
    
    
    
    
    
    # 损失函数
    CELoss = nn.CrossEntropyLoss()
    
    # 定义数据集    
    m_Dataset= WavNet_Dataset(para,receptive_field,para.output_length)
    print(len(m_Dataset))
    m_DataLoader = DataLoader(m_Dataset,batch_size = para.batch_size,shuffle = True, num_workers = 8)
    
    
    # 开始训练  
    for epoch in range(para.n_epoch):
        # 调整lr
        if epoch>para.start_decay and  (epoch-para.start_decay)%(para.lr_update_epoch)==0:
           lr, m_optimizer= adjust_lr_rate(m_optimizer,lr,para.decay_lr)
        
        for i, sample_batch in enumerate(m_DataLoader):
            loss = []
            train_data = sample_batch[0]
            train_target = sample_batch[1]
            train_data = train_data.to(device)
            train_target = train_target.to(device)  # [B,out_length]
            
            outputs = m_model(train_data)  # [B,C,out_length]
            outputs = outputs.transpose(1,2).contiguous().view(-1,para.classes) #[B*out_length,C]
            train_target = train_target.view(-1) # [B*out_length]
            
            # 计算损失函数
            m_loss = CELoss(outputs,train_target)
            
            m_optimizer.zero_grad()
            m_loss.backward()
            m_optimizer.step()
            
            loss.append(m_loss.cpu().detach().numpy() )
            
            # log 输出
            logger.info("epoch %8d  step %8d loss= %f"%(epoch,i,m_loss))
           
        # 保存模型
        path_save = os.path.join(para.path_save,str(epoch))
        os.makedirs(path_save,exist_ok=True)
                
        torch.save({'model':m_model.state_dict(),
                    'opt':m_optimizer.state_dict()},
                    os.path.join(path_save,'model.pick'))
        
        logger.info("epoch %8d  loss_mean= %f"%(epoch,np.mean(loss)))
           
            
       
    




