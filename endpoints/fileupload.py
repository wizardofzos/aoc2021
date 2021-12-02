from marshmallow import Schema, fields

class FileSchema(Schema):
    puzzle = fields.Raw(required=True, description="Puzzle Input", type='file')