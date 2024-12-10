# Test if the calculation worked 
import pytest

def convert_to_float(value):
    try:
        float(value)
        return True
    except ValueError:
        return False

@pytest.mark.parametrize("file", ["outputs/fort_files/fort.16"])
def test_values(file):
    with open(file) as f:
        for line in f:
            stripped = line.strip().split()
        if len(stripped) > 1:
            assert convert_to_float(stripped[1])
