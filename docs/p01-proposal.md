# U.S. Forest Fires: Project Proposal 
Code Name: USFS

Authors: Juan Carlos (juancg@uw.edu), Chantalle Matro (cmatro@uw.edu), Militha Madur (militham@uw.edu) 

Affiliation: INFO-201: Technical Foundations of Informatics - The Information School - University of Washington

Date: Autumn 2022

Abstract:

Keywords: forest fires, climate change

## Introduction:

## Problem Domain:

## Research Questions:

1. **What is the most frequent cause of forest fires?**
- Knowing the source of these forest fires is vital in the implementation of prevention strategies. Wildfire agencies will also be able to prepare for the effects of the disaster and even advise citizens about the fires and steps to take.
2. **Which locations do forest fires most frequently occur?**
- Recognizing the locations in which forest fires happen the most allows for more attention to these vulnerable areas. This aids in prevention by being more aware of fire hazards and better preparation of fire engines.
3. **How do forest fires affect the environment?**
- Climate change is prevalent in the world, and forest fires are one of its greatest contributors because of their disruptive effects. Despite this, there may still be some benefits. It’s important to know these consequences to formulate better practices for preventing long-term rising shifts in temperature.

## Dataset:

1. The dataset on Redivis (derived from the U.S. Forest Service) provides information about U.S. forest fires from 1992 to 2022. It contains data such as fire location, size, cause, etc. Since the concern is climate change, this source will help in the preparation for future fires and their prevention. With this dataset, readers are able to be informed and even use it to create new resources (such as apps) to spread awareness about the world’s current state.

2. Table & Citation

| Name                     | Purpose | Num. of observations | Num. of variables | Citation | URL |
|--------------------------|---------|----------------------|-------------------|----------|-----|
| US Forest Services Fires | This dataset provides U.S. public wildfire data distributed by the U.S. Forest Service. | - | - | Redivis Demo Organization (2022). US Forest Service Fires (v1.1). Redivis. (Dataset) [`link to site`](https://redivis.com/datasets/5k9t-07xsg7ckc?v=1.1) | [`URL`](https://redivis.com/datasets/5k9t-07xsg7ckc?v=1.1) |
| US Fire Origin Points (table 1) | This dataset shows fire origin points, including time, county, intensity level, cause, etc. | 328,985 | 78 | Redivis Demo Organization (2022). US Fire Origin Points. Redivis. (Dataset) [`link to site`](https://redivis.com/datasets/5k9t-07xsg7ckc/tables/5r3s-4s2avr2eb?variable=initial_response) | [`URL`](https://redivis.com/datasets/5k9t-07xsg7ckc/tables/5r3s-4s2avr2eb?variable=initial_response) |
| US Fire Perimeters (table 2) | This dataset shows fire perimeters. | 46,557 | 31 | Redivis Demo Organization (2022). US Fire Perimeters. Redivis. (Dataset) [`link to site`](https://redivis.com/datasets/5k9t-07xsg7ckc/tables/9r58-8ckedbnhw) | [`URL`](https://redivis.com/datasets/5k9t-07xsg7ckc/tables/9r58-8ckedbnhw) |
| US Fires Compiled (table 3) | This dataset shows a summary of all recorded fires. | 1,880,465 | 38 | Redivis Demo Organization (2022). US Fires Compiled. Redivis. (Dataset) [`link to site`](https://redivis.com/datasets/5k9t-07xsg7ckc/tables/t935-9twa6qwpz) | [`URL`](https://redivis.com/datasets/5k9t-07xsg7ckc/tables/t935-9twa6qwpz) |

3. Provenance
The data is distributed by the U.S. Forest Services (USFS), and the main contributor is Ian Mathews (data curator). The datasets were last updated on October 6, 2022 and dates back from as early as 1992. USFS, an agency under the U.S. Department of Agriculture, encourages citizens to use their data to create maps, apps, and other information products. Those who utilize this resource are able to make money with their creations. The dataset was obtained from Redivis, a site that allows different organizations to upload and manage datasets.

**Creator:** Redivis Demo Organization
**Contributors:** Ian Mathews (Data curator)
**Related identifiers:** https://data-usfs.hub.arcgis.com/
**Citation:** Redivis Demo Organization (2022). US Forest Service Fires (v1.1). Redivis. 
(Dataset) https://redivis.com/datasets/5k9t-07xsg7ckc?v=1.1

## Expected Implications:

One of the expected implications is that we will be able to tell what type of environment and what starts forest fires. Also, in which locations the forest fires grow to be the biggest. This could help someone like the U.S. Forest Service to be able to see which areas are at higher risk of becoming fire hazards so that they are more prepared for them. And what causes the forest fires so that they could put out PSAs to make sure the community is also helping protect the forests.

Another implication would be to help those who live around the area of where fires could start be aware of them so that they could be prepared if they do happen again or try to prevent them from even happening. For example, if someone sees that they live in an area that frequently has forest fires and/or is affected by them, they could be better prepared by getting the necessary gear for it, and also because they know it is possible in their area to be more aware of trying to prevent it from happening.

## Limitations:

In the Statistical_cause column, the cause of the fire, some of the entries can be pretty vague. Like, “Miscellaneous” or “Equipment.Use”.
Some of the fires have names while others don’t.

### Addressing the Limitations:

One way to address the first limitation is to only include the ones that were caused by forest fires that were bigger than one acre. This is because the bigger the forest fire is, the more information there will likely be for it.
To address the second limitation would be to address the fires by the location that they were at instead of the name given to them, whether it be the coordinates that were given or the state that they occurred in.


For what to do, see the [`../instructions/`](../instructions/) directory, specifically: 

* [Design Brief](../instructions/project-design-brief.pdf)
* [Project Proposal Requirements](../instructions/p01-proposal-requirements.md)
