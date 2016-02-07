import numpy as np

def pred(w,X):
  p = np.sign(X*w)
  p[p==0]=-1
  return p


with open("./hw1_15_train.dat",'r') as fp:
  train_data = np.matrix([map(float,line.split()) for line in fp])

N = np.size(train_data,axis=0)
d = np.size(train_data,axis=1)
trainX = np.concatenate((np.ones((N,1)),train_data[:,:-1]),axis=1)
trainy = train_data[:,-1]

cntlist = []
for i in xrange(2000):
  cnt = 0
  w = np.zeros((d,1))
  predy = pred(w,trainX)
  while np.where(predy!=trainy)[0].size != 0:
    inds = np.where(predy!=trainy)[0]
    ind = inds[0,np.random.randint(inds.size)]
    m = trainX[ind].transpose()*trainy[ind]
    w += m
    cnt+=1
    predy = pred(w,trainX)

  cntlist.append(cnt)

print float(sum(cntlist))/ len(cntlist)