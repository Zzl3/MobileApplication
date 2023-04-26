import torch
class hparams():
    def __init__(self):
        self.path_train_wavs = 'data'
        self.path_train_coded = 'data_coded'
        
        self.fs = 16000
        self.classes  =256
        
        # 模型相关
        self.layers = 10
        self.blocks = 3
       
        self.residual_channels = 64
        self.skip_channels = 512
        self.end_channels = 512
        self.output_length=128
        
        
        # 训练相关
        self.n_epoch = 30
        self.lr = 0.001
        self.batch_size = 32
        self.path_save = 'save'
        
        
        self.start_decay = 10
        self.lr_update_epoch = 1
        self.decay_lr = self.lr/10
        
       
        
      
        
        
        