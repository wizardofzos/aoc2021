
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE
import uuid
import os

from .fileupload import FileSchema

#  Restful way of creating APIs through Flask Restful
class PYTHOND12(MethodResource, Resource):
    @doc(description='Thanks to https://github.com/SnoozeySleepy/AdventofCode/blob/main/day11.py', tags=['PYTHON'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    @use_kwargs(FileSchema, location='files')
    def post(self, puzzle):
        # stick the file somewhere
        infile = f"/tmp/{uuid.uuid4()}"
        puzzle.save(infile)  # will go be iso8859-1 
        caves = [line.strip().split("-") for line in open(infile, "r").readlines()]
        options = {cave: set() for cave in {cave for edge in caves for cave in edge}}
        for cave_1, cave_2 in caves:
            if cave_2 != "start":
                options[cave_1].add(cave_2)
            if cave_1 != "start":
                options[cave_2].add(cave_1)


        def useNewMap(nextpos, visited, part2):
            if not part2:
                return True
            if nextpos in visited and nextpos.islower():
                return True
            return False


        lookupTable = {}
        # bad woinky :) 
        def howmany(position, choices, visited, part2):
            key = (position, "".join(sorted(visited)), part2)
            if key in lookupTable:
                return lookupTable[key]
  
            assert visited[-1] == position
            if position == "end":
                return 1

            number_of_paths = 0
            for nextpos in choices[position]:
                if useNewMap(nextpos, visited, part2):
                    next_part2 = False
                    nextops = {
                        cave: {c for c in choices if c not in visited or c.isupper()}
                        for cave, choices in choices.items()
                    }
                else:
                    next_part2 = part2
                    nextops = choices

                number_of_paths += howmany(
                    nextpos,
                    nextops,
                    visited + [nextpos],
                    next_part2,
                )
            lookupTable[key] = number_of_paths

            return lookupTable[key]


        p1 = howmany("start", options, ["start"], False)
        p2 = howmany("start", options, ["start"], True)
        os.remove(infile)     
        return {'solution': {'part1': p1,'part2': p2 }}
        