from dagster import *
import logging

            

@op
def file_log_op(context: OpExecutionContext):
    context.log.info("Hello world!")


@job
def file_log_job():
    file_log_op()