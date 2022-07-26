# RegisterQD

[![CI](https://github.com/HolyLab/RegisterQD.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/HolyLab/RegisterQD.jl/actions/workflows/CI.yml)[![codecov](https://codecov.io/gh/HolyLab/RegisterQD.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/HolyLab/RegisterQD.jl)

RegisterQD performs image registration using the global optimization routine [QuadDIRECT](https://github.com/timholy/QuadDIRECT.jl).
Unlike many other registration packages, this is not "greedy" descent based on an initial guess---it attempts to find the globally-optimal alignment of your images.

This package allows users to choose to between using CPU and GPU processing by first using either RegisterMismatch (CPU) or RegisterMismatchCuda (GPU), which contain critical overlapping functions that RegisterQD will not function without a version of. 
In the current absense of Github resources for GPU code, "gpu_test.jl" should be run on your personal machine as required. 

This package exports the following registration functions:
- `qd_translate`: register images by shifting one with respect to another (translations only)
- `qd_rigid`: register images using rotations and translations
- `qd_affine`: register images using arbitrary affine transformations

In general, using more degrees of freedom allows you to solve harder optimization problems, but also makes it harder to find the global optimum. Your best strategy is to permit no more degrees of freedom than needed to solve the problem.

See the help on these functions for details about how to call them.

Another important feature of this package is that it supports images that were sampled anisotropically. This is particularly common for three-dimensional biomedical imaging, where MRI and optical microscopy typically have one axis sampled at lower resolution.
A rotation (from a rigid transformation) in physical space needs to be modified before applying it to an anisotropically-sampled image; see `arrayscale` and `getSD` for more information.

**NOTE**: see NEWS.md for information about a recent breaking change.
