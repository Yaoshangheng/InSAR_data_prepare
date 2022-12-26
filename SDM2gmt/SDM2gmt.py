'''
-*- coding: utf-8 -*-
author: Yuan Yao
Usage：convert SDM output data to gmt plot3d 
$ python SDM2gmt.py
Parameters:0.0225 change it when you need different size of grid
Time  : 2022/12/26
'''

import re
import pandas as pd

with open('slip.dat','r') as f:
    df = f.readlines()
for i in range(len(df)):
    df[i] = df[i].strip()
    df[i]= re.split(r" +",df[i])


def method(lis):
    infdic = {}
    lis1 = [eval(lis[1])-0.0225,eval(lis[0])+0.0225,-eval(lis[2])+1]
    lis2 = [eval(lis[1])+0.0225,eval(lis[0])+0.0225,-eval(lis[2])+1]
    lis3 = [eval(lis[1])+0.0225,eval(lis[0])-0.0225,-eval(lis[2])-1]
    lis4 = [eval(lis[1])-0.0225,eval(lis[0])-0.0225,-eval(lis[2])-1]
    infdic['>  -Z{}'.format(lis[7])] = [lis1,lis2,lis3,lis4]
    for i in range(4):
        for j in range(3):
            infdic['>  -Z{}'.format(lis[7])][i][j] = str(round(infdic['>  -Z{}'.format(lis[7])][i][j],4))
    text = ''
    for i,j in infdic.items():
        text += i + '\n'
        for m in j:
            a = '  '.join(m) + '\n'
            text += a
    with open('slip_3dgrid.gmt','a') as f:
        f.write(text)


if __name__ == '__main__':
    for i in df[1:]:
        try:
            method(i)
        except:
            pass