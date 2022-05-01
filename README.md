# Panorama Stitching

Combines multiple images with overlapping fields of view to produce a segmented Panorama by making homographies between them. By doing homographies transformations and blending them together nicely we can make Panoramas out of multiple images.

This is part of an optional Lab Assignment from the [Computer Vision](http://www.cvc.uab.es/shared/teach/a102784/) course at [UAB](https://www.uab.cat/).

## Overview

#### Input Images

<p align="center">
<img src="/input_imgs/field/image001.jpg" width="250"/>
<img src="/input_imgs/field/image002.jpg" width="250"/>
<img src="/input_imgs/field/image003.jpg" width="250"/>
</p>

#### Output generated

<p align="center">
<img src="/output_imgs/panorama_pla_camp.jpg"/>
</p>

## References

This project is based on "[Automatic Panoramic Image Stitching using Invariant Features](http://matthewalunbrown.com/papers/ijcv2007.pdf)" by Matthew Brown and David G. Lowe.
