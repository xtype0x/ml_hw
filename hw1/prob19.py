import numpy as np

def pred(w,X):
  p = np.sign(X*w)
  p[p==0]=-1
  return p


with open("./hw1_18_train.dat",'r') as fp:
  train_data = np.matrix([map(float,line.split()) for line in fp])
with open("./hw1_18_test.dat",'r') as fp:
  test_data = np.matrix([map(float,line.split()) for line in fp])

N = np.size(train_data,axis=0)
testN = np.size(test_data,axis=0)
d = np.size(train_data,axis=1)
trainX = np.concatenate((np.ones((N,1)),train_data[:,:-1]),axis=1)
trainy = train_data[:,-1]
testX = np.concatenate((np.ones((testN,1)),test_data[:,:-1]),axis=1)
testy = test_data[:,-1]

errs = []

for t in xrange(2000):
  min_err = 1.0
  w = np.zeros((d,1))
  predy = pred(w,trainX)
  for i in xrange(50):
    inds = np.where(predy!=trainy)[0]
    ind = inds[0,0]
    m = trainX[ind].transpose()*trainy[ind]
    w += m
    predy = pred(w,trainX)

  err_rate = (pred(w,testX)!=testy).mean()
  errs.append(err_rate)

print sum(errs)/len(errs)
