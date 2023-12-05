

import logging
 
from dagster import *
 
def test_init_json_console_logger_with_context():
    # Set the logging level globally
    logging.basicConfig(level=logging.DEBUG)
 
    logger_ = json_console_logger(
        build_init_logger_context(logger_config={"name": "my_logger"})
    )
 
    # Use the configured logging level
    logger_.info("This is an INFO message")
    logger_.debug("This is a DEBUG message")
 
    # Check the logger level
    actual_level = getattr(logger_, "_level", 10)
    assert actual_level == logging.DEBUG