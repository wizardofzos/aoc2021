from marshmallow import Schema, fields

class FileSchema(Schema):
    puzzle = fields.Raw(required=True, description="Puzzle Input", type='file')

class COBOLFileSchema(Schema):
    puzzle = fields.Raw(required=False, description="Puzzle Input", type='file')
    cobolsource = fields.Raw(required=True, description="Puzzle Input", type='file')