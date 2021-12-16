
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE
import uuid
import os

from .fileupload import FileSchema

#  Restful way of creating APIs through Flask Restful
class PYTHOND15(MethodResource, Resource):
    @doc(description='D15', tags=['PYTHON'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    @use_kwargs(FileSchema, location='files')
    def post(self, puzzle):
        # stick the file somewhere
        infile = f"/tmp/{uuid.uuid4()}"
        puzzle.save(infile)  # will go be iso8859-1 
        from collections import deque as de
        x = open(infile,"r").readlines()
        for i in range(len(x)):
            x[i] = x[i].strip()
        
        x=[[int(i) for i in r]for r in x]
        t=100000000000000000000000000000000000000000000000000000
        q = de([0,0,0])
        v = set()
        while q:
            a,b,c=q.popleft()
            if (a,b,c) in v:
                continue
            v.add((a,b,c))
            if (a,b)==(len(x)-1,len(x[0])-1):
                t = min(t,c)
                continue
            try:
                q.append((a+1,b,x+x[a+1][b]))
            except:
                pass
            try:
                q.append((a,b+1,c+x[a][b+1]))
            except:
                pass
        
        p1 = t


   
        os.remove(infile)  
     
        return {'solution': {'part1': p1,'part2': p2 }}
        