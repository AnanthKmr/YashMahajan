from dagster import *
import pytest



def test_init_json_console_logger():
    logger_ = json_console_logger(None)
    assert logger_.level == 20
    assert logger_.name == "dagster"