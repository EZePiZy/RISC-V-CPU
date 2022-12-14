# Testing and Verification

![CPU_Full](./images/MICROARCHITECTURE.jpg)


## Testing Steps:

### Syntax Checking

* Pass over all components and check for correct naming conventions (`SCREAMING SNAKE CASE` for files, `Pascal Case` for Pins and Wires) of components and labels for connections

* Check for correct naming of components to match that of given diagrams, as well as file names for simplicity

### Component Tests

* Each component needs to be tested on a range of inputs and compared against the corrosponding correct waveforms

* The correct output is recieved from the given input signals for each component, with there respective inputs

### Top File Tests

* Develop a set of test files to run that can be used to check the correct function of the single cycle CPU

* Test each one and see if the desired functions are ran

# Syntax Checking:

### Steps for cleaning Tree:
1. Apply Naming Convention (Screaming Snake Case/Pascal Case/Snake Case)
2. Add vbuddy.cfg and vbuddy.cpp to each dir
3. Create hierarchical structure 
4.  