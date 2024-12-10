# Test to determine if fresco ran and generated all of the output files. When fresco does not finish running,
# fort.16 will not generate 

import os
import pytest

@pytest.mark.parametrize("file", ["outputs/fort_files/fort.16"])
def test_fort16_exists(file):
    assert os.path.isfile(file), f"{file} does not exist"


