from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE

import uuid
import os

from .fileupload import FileSchema, D6Schema


#  Restful way of creating APIs through Flask Restful
class REXXD06P1(MethodResource, Resource):
  
    
    @doc(description="<a target='_blank' href='https://adventofcode.com/2021/day/6'>Day 6</a>" +
    "<br />Videos -> <a target='_blank' href='https://youtu.be/$'>Not Here</a>"
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
        puzzle.save(infile)  # will go be iso8859-1 make ebcdic for the rexx?
        os.system(f"iconv -f iso8859-1 -t ibm-1047 {infile} > {gofile}")
        os.system(f"chtag -tc ibm-1047 {gofile}")
        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/d6p1.rex',gofile], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        os.remove(infile)
        os.remove(gofile)
        print(stdout.decode('utf-8'))
        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}

class REXXD06P2(MethodResource, Resource):
  
    
    @doc(description="<a target='_blank' href='https://adventofcode.com/2021/day/6'>Day 6</a>" +
    "<br />Solves both part one and two. Part one rexx is bad code. this is good code :)"
    , tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    @use_kwargs(FileSchema, location='files')
    @use_kwargs(D6Schema, location='query')
    def post(self, puzzle, days):
        # stick the file somewhere
        infile = f"/tmp/{uuid.uuid4()}"
        gofile = f"/tmp/{uuid.uuid4()}"
        puzzle.save(infile)  # will go be iso8859-1 make ebcdic for the rexx?
        os.system(f"iconv -f iso8859-1 -t ibm-1047 {infile} > {gofile}")
        os.system(f"chtag -tc ibm-1047 {gofile}")
        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/d6p2.rex',f'{gofile} {days}'], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        os.remove(infile)
        os.remove(gofile)
        if parts[0] == "solution":
            return {'solution': parts[1].replace('\n','')}
        else:
            return {'solution': '*FAILED*'}