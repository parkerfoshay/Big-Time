# TODO: Explain why we use aggregate
db.restaurants.aggregate([
    #  TODO: Explain unwind and its position in the pipeline
    {
        '$unwind': {
            'path': '$grades'
        }
    }, 
    # TODO: Explain is happening below:
    {
        '$match': {
            'borough': 'Brooklyn', 
            'cuisine': 'American'
        }
    }, 
    # TODO: Explain is happening below:
    {
        '$group': {
            '_id': '$name', 
            'avgScore': {
                '$avg': '$grades.score'
            }
        }
    }, 
    # TODO: Explain is happening below:
    {
        '$match': {
            'avgScore': {
                '$gte': 30
            }
        }
    }
]).pretty()