from dagster import *
from logging import *

@op
def log_op(context: OpExecutionContext):
    
    context.log.debug("hello, world")
    context.log.error("error ,message")
    context.log.warning('warning ,message')


@graph
def hello_logs():
    log_op()


local_logs = hello_logs.to_job(
    name="local_logs", logger_defs={"console": colored_console_logger}
)
# prod_logs = hello_logs.to_job(
#     name="prod_logs", logger_defs={"cloudwatch": cloudwatch_logger}
# )