from pydub import AudioSegment
from pydub.utils import make_chunks

#path=r"E:\secret\相关比赛\移动应用创新赛\styleTransfer\data\metadata\train\piano\起风了_钢琴.mp3"#待切割文件路径
path=r"E:\secret\相关比赛\移动应用创新赛\styleTransfer\data\metadata\train\guitar\起风了_吉他版.mp3"#待切割文件路径
fm="mp3"#文件格式
audio = AudioSegment.from_file(path, fm)
size = 6000#切割毫秒数

chunks = make_chunks(audio, size)
#print(enumerate(chunks))
for i, chunk in enumerate(chunks):
    if i>29:
        break
    chunk_name = "起风了_吉他-{0}.wav".format(i)
    print(chunk_name)
    chunk.export(r'E:\secret\相关比赛\移动应用创新赛\styleTransfer\data\train\guitar\{}'.format(chunk_name), format="wav")