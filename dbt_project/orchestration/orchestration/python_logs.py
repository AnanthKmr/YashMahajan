import logging

from dagster import *
@op
def ambitious_op():
    my_logger = get_dagster_logger()
    try:
        x = 1 / 0
        return x
    except ZeroDivisionError:
        my_logger.error("Couldn't divide by zero!")

    return None

@job
def demo_job():
    ambitious_op()    