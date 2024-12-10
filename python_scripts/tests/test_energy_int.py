# Test to check the energy integration results are not nonsense 

import pytest 

def convert_to_float(value):
    try:
        float(value)
        return True
    except ValueError:
        return False
    
@pytest.mark.parametrize("file", ["outputs/integrated_cross_sections/energy_integration.txt"])
def test_values(file):
    with open(file) as f:
        for line in f:
            stripped = line.strip().split()
        if len(stripped) > 1:
            assert convert_to_float(stripped[1])