# Flo-Posit

Instances of parametrized VHDL Posit Arithmetic units generated with the FloPoCo tool (http://flopoco.gforge.inria.fr/).
These operators support the posit standard including round to nearest-even method.

FloPoCo allows to generate VHDL code for Posit⟨_n,es_⟩ arithmetic units with any configuration of bitwidth (_n_) and exponent-size (_es_). This repository contains concrete generated instances to facilitate its use and dissemination.

## Available arithmetic units
* Posit Adder
* Posit Multiplier

## Reference
This work is based on folowing article. Please refer it for more detailed description of the posit cores.
If you find this code useful in your research, please consider citing:

> R. Murillo, A. A. Del Barrio and G. Botella, "Customized Posit Adders and Multipliers using the FloPoCo Core Generator," 2020 IEEE International Symposium on Circuits and Systems (ISCAS), 2020, pp. 1-5, doi: [10.1109/ISCAS45731.2020.9180771](https://doi.org/10.1109/ISCAS45731.2020.9180771).

## License

[GPL v3.0 license](LICENSE)