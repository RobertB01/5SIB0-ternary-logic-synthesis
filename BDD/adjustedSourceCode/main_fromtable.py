"""
Adjusted code from:
Ternary Circuit Synthesis Using 2:1 Multiplexers.
[Online]. Available: https://github.com/chetankv/Ternary-Synthesis

Created on Thu Oct  5 15:56:41 2017

@author: chetan and M.B.Srinivas

"""
from Synthesis_Algorithm import *
import NetList_Gen
import re
import os

import scipy.io as sio
import numpy as np

# open truth table from matlab
mat_file = sio.loadmat('table.mat')
mat_table = mat_file['Truth_table']
table_array = np.array(mat_table)
n_outputs = 2
n_inputs = len(table_array[0])-n_outputs
print('Number of input variables:', n_inputs)
print('Number of output variables:', n_outputs)

# Print the resulting array
print(table_array)

BTDD_Total_Graph, In_Cost2x, Cost, Final_Mux2, Tc = in_args(table_array, n_inputs, n_outputs);

#print('No. 2:1 Muxes for other inputs',In_Cost2x)
#print('No. 2:1 Muxes for 2-input Fun.',Cost)
#print('No. of Total 2:1 Muxes',Final_Mux2)
#print('Transistor Count (without PTI NTI binot inverters)::', Tc)