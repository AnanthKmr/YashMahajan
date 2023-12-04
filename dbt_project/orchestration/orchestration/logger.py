from dagster import job, op, OpExecutionContext


@op
def hello_logs(context: OpExecutionContext):
    context.log.info("Hello, world!")


@job
def demo_job():
    hello_logs()