from setuptools import find_packages, setup

setup(
    name="casino1",
    packages=find_packages(exclude=["casino1_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
