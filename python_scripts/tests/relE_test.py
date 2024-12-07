# Test if the calculation worked 
import pytest

def convert_to_float(value):
    try:
        float(value)
        return True
    except ValueError:
        return False
    
def test_values():
    with open(snakemake.input[0]) as f:
        for line in f:
            stripped = line.strip().split()
        if len(stripped) > 1:
            assert convert_to_float(stripped[1])
if __name__ == "__main__":
    pytest.main()