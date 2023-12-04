
from dagster import job, op, OpExecutionContext


@op
def hello_logs_error(context: OpExecutionContext):
    raise Exception("Somebody set up us the bomb")

@graph
def demo_job_error():
    hello_logs_error()