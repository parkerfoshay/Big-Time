# TODO: Explain why we use aggregate
# Since we want to use the aggregation framework, we need to use .aggregate() instead of .find().
# .find() only allows us to use MQL and not create an aggregation pipeline.
db.restaurants.aggregate([
    # TODO: Explain unwind and its position in the pipeline
    # Here we are flattening the grades array so that we can access the object inside.
    # We will use this flattened array later in the pipeline.
    # This is the beginning of the pipeline.
    {
        '$unwind': {
            'path': '$grades'
        }
    }, 
    # TODO: Explain is happening below:
    # After we flattened the array, we query for borough's matching Brooklyn and American cuisine.
    # Position numer 2 in the pipeline.
    {
        '$match': {
            'borough': 'Brooklyn', 
            'cuisine': 'American'
        }
    }, 
    # TODO: Explain is happening below:
    # Now the pipeline groups our queries by name and we also calculate the average score for each restaurant.
    # Position numer 3 in the pipeline
    {
        '$group': {
            '_id': '$name', 
            'avgScore': {
                '$avg': '$grades.score'
            }
        }
    }, 
    # TODO: Explain is happening below:
    # Finally, we query for all the average scored restaurants above a score of 30.
    # Position numer 4 in the pipeline
    {
        '$match': {
            'avgScore': {
                '$gte': 30
            }
        }
    }
]).pretty()