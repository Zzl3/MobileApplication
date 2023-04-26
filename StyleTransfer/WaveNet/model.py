import torch.nn as nn
import torch
import numpy as np
import torch.nn.functional as F
from hparams import hparams
from dataset import WavNet_Dataset
from torch.utils.data import Dataset,DataLoader

# 膨胀卷积层
class DilatedConv1d(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size=2, stride=1,
                 padding=0, dilation=1, bias=False):
        super(DilatedConv1d, self).__init__()
    
        self.layer = nn.Conv1d(in_channels = in_channels,
                               out_channels = out_channels,
                               kernel_size = kernel_size,
                               stride=stride,
                               padding=padding,
                               dilation=dilation,
                               bias=bias)
    
    def forward(self, inputs):
        outputs = self.layer(inputs)
        return outputs


# 残差 连接层
class ResidualBlock(nn.Module):
    
    def __init__(self, residual_channels, skip_channels, dilation):
        super(ResidualBlock, self).__init__()
        self.filter_conv = DilatedConv1d(in_channels=residual_channels,
                                         out_channels=residual_channels, 
                                         dilation=dilation)
                                         
        self.gate_conv = DilatedConv1d(in_channels=residual_channels, 
                                       out_channels=residual_channels, 
                                       dilation=dilation)
                                       
        self.residual_conv = nn.Conv1d(in_channels=residual_channels, 
                                       out_channels=residual_channels, 
                                       kernel_size=1)
                                       
        self.skip_conv = nn.Conv1d(in_channels=residual_channels, 
                                   out_channels=skip_channels, 
                                   kernel_size=1)
      
    def forward(self,inputs):
        
        sigmoid_out = torch.sigmoid(self.gate_conv(inputs))
        tahn_out = torch.tanh(self.filter_conv(inputs))
        output = sigmoid_out * tahn_out

        res_out = self.residual_conv(output)
        res_out = res_out + inputs[:, :, -res_out.size(2):] # 残差连接

        skip_out = self.skip_conv(output)
       
        return res_out , skip_out



class WavNet(nn.Module):
    def __init__(self,para):
        super(WavNet, self).__init__()
        
        # 模型包括 blocks个块
        # 每个块包含 self.layers 层
        self.layers = para.layers
        self.blocks = para.blocks
       
        self.residual_channels = para.residual_channels
        self.skip_channels = para.skip_channels
        self.classes = para.classes
        self.end_channels = para.end_channels
    
        self.dilations = [2**i for i in range(self.layers)] * self.blocks
        
        # 初始化卷积层
        self.start_conv = nn.Conv1d(in_channels=self.classes,
                                    out_channels=self.residual_channels,
                                    kernel_size=1,
                                    bias=False)
                                    
        # 堆叠的残差连接层
        self.main = nn.ModuleList([ResidualBlock(self.residual_channels,self.skip_channels,dilation) for dilation in self.dilations])
        
        # 后继的对skip_out进行的处理
        self.post = nn.Sequential(nn.ReLU(),
                                  nn.Conv1d(self.skip_channels,self.end_channels,1),
                                  nn.ReLU(),
                                  nn.Conv1d(self.end_channels,self.classes,1))
                                  
        # 计算 receptive_field
        self.receptive_field = 1
        for b in range(self.blocks):
            additional_scope = 1
            for i in range(self.layers):
                self.receptive_field += additional_scope
                additional_scope *= 2
                
                
    def forward(self,inputs):
        outputs = self.start_conv(inputs)
        skip_connections = []
        
        for layer in self.main:
            outputs,skip = layer(outputs)
            skip_connections.append(skip)
            
        outputs = sum([s[:,:,-outputs.size(2):] for s in skip_connections])
        outputs = self.post(outputs)
        
        return outputs
        
        
if __name__ == "__main__":
    
    para = hparams()
    # 定义模型
    model = WavNet(para)
    receptive_field = model.receptive_field
    print("receptive_field",receptive_field)
    # 定义数据集
    m_Dataset= WavNet_Dataset(para,receptive_field,para.output_length)
    
    m_DataLoader = DataLoader(m_Dataset,batch_size = 32,shuffle = True, num_workers = 8)
    print("len_datset",len(m_Dataset))
    
    # for i_batch, sample_batch in enumerate(m_DataLoader):
        # train_data = sample_batch[0]
        # train_target = sample_batch[1]
        
        # print('train_data',train_data.shape)
        
        # outputs = model(train_data)
        # print("outputs",outputs.shape)
        
        # print("train_target",train_target.shape)
        
        # if i_batch>5:
            # break

    
    
    
    
    
    
    
    
                
                                    
                                    
                                    
                                    
                                    
                                    