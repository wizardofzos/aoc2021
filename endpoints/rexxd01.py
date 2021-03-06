from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE

import uuid
import os


from .fileupload import FileSchema

#  Restful way of creating APIs through Flask Restful
class REXXD01P1(MethodResource, Resource):
    
    @doc(description="<a target='_blank' href='https://adventofcode.com/2021/day/1'>Day 1</a>" 
    , tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    @use_kwargs(FileSchema, location='files')
    def post(self, puzzle):
        # stick the file somewhere
        infile = f"/tmp/{uuid.uuid4()}"
        gofile = f"/tmp/{uuid.uuid4()}"
        puzzle.save(infile)  # will go be iso8859-1
        os.system(f"iconv -f iso8859-1 -t ibm-1047 {infile} > {gofile}")
        os.system(f"chtag -tc ibm-1047 {gofile}")
        print(infile)
        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/2021d1p1.rex',gofile], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        os.remove(infile)
        os.remove(gofile)

        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}
        



class REXXD01P2(MethodResource, Resource):
    @doc(description="<a target='_blank' href='https://adventofcode.com/2021/day/1'>Day 1</a>"
    , tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    @use_kwargs(FileSchema, location='files')
    def post(self, puzzle):
         # stick the file somewhere
        infile = f"/tmp/{uuid.uuid4()}"
        gofile = f"/tmp/{uuid.uuid4()}"
        puzzle.save(infile)  # will go be iso8859-1
        os.system(f"iconv -f iso8859-1 -t ibm-1047 {infile} > {gofile}")
        os.system(f"chtag -tc ibm-1047 {gofile}")
        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/2021d1p2.rex', gofile], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        os.remove(infile)
        os.remove(gofile)
        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}