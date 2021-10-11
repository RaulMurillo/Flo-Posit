# Flo-Posit

Instances of parametrized VHDL Posit Arithmetic units generated with the FloPoCo tool (http://flopoco.gforge.inria.fr/).
These operators support the posit standard including round to nearest-even method.

FloPoCo allows to generate VHDL code for Posit⟨_n,es_⟩ arithmetic units with any configuration of bitwidth (_n_) and exponent-size (_es_). This repository contains concrete generated instances to facilitate its use and dissemination.

## Available arithmetic units
* [Posit Adder](/PositAdd)
* [Posit Multiplier](./PositMult)
* [Posit Fused Multiply-accumulate](./PositMAC) (MAC) with **quire support**
* [Posit Logarithm-Approximate Multiplier](./PositLAM)

## Reference
This work is the result from the following articles. Please refer to them for more detailed description of the posit cores.  
If you find this code useful in your research, please consider citing:

> R. Murillo, A. A. Del Barrio and G. Botella, "Customized Posit Adders and Multipliers using the FloPoCo Core Generator," *2020 IEEE International Symposium on Circuits and Systems (ISCAS)*, 2020, pp. 1-5, doi: [10.1109/ISCAS45731.2020.9180771](https://doi.org/10.1109/ISCAS45731.2020.9180771).
```
@inproceedings{murillo2020customized,
  title={Customized posit adders and multipliers using the FloPoCo core generator},
  author={Murillo, Raul and Del Barrio, Alberto Antonio and Botella, Guillermo},
  booktitle={2020 IEEE International Symposium on Circuits and Systems (ISCAS)},
  pages={1--5},
  year={2020},
  doi={10.1109/ISCAS45731.2020.9180771},
  url={https://ieeexplore.ieee.org/document/9180771},
  organization={IEEE}
}
```
> R. Murillo, A. A. Del Barrio Garcia, G. Botella, M. S. Kim, H. Kim and N. Bagherzadeh, "PLAM: a Posit Logarithm-Approximate Multiplier," in *IEEE Transactions on Emerging Topics in Computing*, doi: [10.1109/TETC.2021.3109127](https://doi.org/10.1109/TETC.2021.3109127).
```
@article{murillo2021plam,
  title={PLAM: a Posit Logarithm-Approximate Multiplier},
  author={Murillo, Raul and Del Barrio, Alberto Antonio and Botella, Guillermo and Kim, Min Soo and Kim, Hyunjin and Bagherzadeh, Nader},
  journal={IEEE Transactions on Emerging Topics in Computing},
  year={2021},
  volume={},
  number={},
  pages={1-1},
  doi={10.1109/TETC.2021.3109127}},
  url={https://ieeexplore.ieee.org/document/9530365},
  publisher={IEEE}
}
```

## License

[GPL v3.0 license](LICENSE)
