# Flo-Posit

Instances of parametrized VHDL Posit Arithmetic units generated with the FloPoCo tool (http://flopoco.gforge.inria.fr/).
These operators support the posit standard including round to nearest-even method.

FloPoCo allows to generate VHDL code for Posit⟨_n,es_⟩ arithmetic units with any configuration of bitwidth (_n_) and exponent-size (_es_). This repository contains concrete generated instances to facilitate its use and dissemination.

## Available arithmetic units
* [Posit Adder](/PositAdd)
* [Posit Multiplier](./PositMult)
* [Posit Divider](./PositDiv) using **non-restoring algorithm**
* [Posit Fused Multiply-accumulate](./PositMAC) (MAC) with **quire support**
* [Posit Logarithm-Approximate Multiplier](./PositLAM)

## Reference
This work is the result of the following articles. Please refer to them for a more detailed description of the posit cores.  
If you find this code useful in your research, please consider citing:

> R. Murillo, A. A. Del Barrio and G. Botella, "Customized Posit Adders and Multipliers using the FloPoCo Core Generator," *2020 IEEE International Symposium on Circuits and Systems (ISCAS)*, 2020, pp. 1-5, doi: [10.1109/ISCAS45731.2020.9180771](https://doi.org/10.1109/ISCAS45731.2020.9180771).
```
@inproceedings{murillo2020customized,
  title={{Customized posit adders and multipliers using the FloPoCo core generator}},
  author={Murillo, Raul and Del Barrio, Alberto Antonio and Botella, Guillermo},
  booktitle={2020 IEEE International Symposium on Circuits and Systems (ISCAS)},
  pages={1--5},
  year={2020},
  doi={10.1109/ISCAS45731.2020.9180771}
}
```
> R. Murillo, A. A. Del Barrio Garcia, G. Botella, M. S. Kim, H. Kim and N. Bagherzadeh, "PLAM: a Posit Logarithm-Approximate Multiplier," in *IEEE Transactions on Emerging Topics in Computing* (2021), doi: [10.1109/TETC.2021.3109127](https://doi.org/10.1109/TETC.2021.3109127).
```
@article{murillo2021plam,
  title={{PLAM: a Posit Logarithm-Approximate Multiplier}},
  author={Murillo, Raul and Del Barrio, Alberto Antonio and Botella, Guillermo and Kim, Min Soo and Kim, Hyunjin and Bagherzadeh, Nader},
  journal={IEEE Transactions on Emerging Topics in Computing},
  year={2021},
  volume={10},
  number={4},
  pages={2079--2085},
  doi={10.1109/TETC.2021.3109127}
}
```
> R. Murillo, D. Mallasén, A. A. Del Barrio Garcia and G. Botella, "Energy-Efficient MAC Units for Fused Posit Arithmetic." *2021 IEEE 39th International Conference on Computer Design (ICCD)*. IEEE, 2021, doi: [10.1109/ICCD53106.2021.00032](https://doi.org/10.1109/ICCD53106.2021.00032).
```
@inproceedings{murillo2021energy,
  title={{Energy-Efficient MAC Units for Fused Posit Arithmetic}},
  author={Murillo, Raul and Mallas{\'e}n, David and Del Barrio, Alberto A. and Botella, Guillermo},
  booktitle={2021 IEEE 39th International Conference on Computer Design (ICCD)},
  pages={138--145},
  year={2021},
  doi={10.1109/ICCD53106.2021.00032}
}
```
> R. Murillo, D. Mallasén, A. A. Del Barrio Garcia and G. Botella, "Comparing different decodings for posit arithmetic." *Conference on Next Generation Arithmetic*. Springer, Cham, 2022, doi: [10.1007/978-3-031-09779-9_6](https://doi.org/10.1007/978-3-031-09779-9_6).
```
@inproceedings{murillo2022comparing,
  title={Comparing different decodings for posit arithmetic},
  author={Murillo, Raul and Mallas{\'e}n, David and Del Barrio, Alberto A. and Botella, Guillermo},
  booktitle={Conference on Next Generation Arithmetic},
  pages={84--99},
  year={2022},
  doi={10.1007/978-3-031-09779-9_6},
  organization={Springer}
}
```
> R. Murillo, A. A. Del Barrio Garcia and G. Botella, "A Suite of Division Algorithms for Posit Arithmetic." *2023 IEEE 34th International Conference on Application-specific Systems, Architectures and Processors (ASAP)*. IEEE, 2023, doi: [10.1109/ASAP57973.2023.00020](https://doi.org/10.1109/ASAP57973.2023.00020).
```
@inproceedings{murillo2023suite,
  title={{A Suite of Division Algorithms for Posit Arithmetic}},
  author={Murillo, Raul and Del Barrio, Alberto A. and Botella, Guillermo},
  booktitle={2023 IEEE 34th International Conference on Application-specific Systems, Architectures and Processors (ASAP)},
  pages={41--44},
  year={2023},
  doi={10.1109/ASAP57973.2023.00020},
  organization={IEEE}
}
```

## License

[GPL v3.0 license](LICENSE)

## Acknowledgements
This work was supported by a 2020 Leonardo Grant for Researchers and Cultural Creators, from BBVA Foundation, whose id is PR2003 20/01, by the EU(FEDER) and the Spanish MINECO under grant RTI2018-093684-B-I00, by the CM under grant S2018/TCS-4423, and by MCIN/AEI/ 10.13039/501100011033 and “ERDF A way of making Europe” under grant PID2021-123041OB-I00.
