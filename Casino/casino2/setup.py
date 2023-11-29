from setuptools import find_packages, setup

setup(
    name="casino2",
    packages=find_packages(exclude=["casino2_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
