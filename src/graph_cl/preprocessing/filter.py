from ..data_models.Data import DataConfig
from ..data_models.Model import ModelGCLConfig
from ..data_models.Sample import Sample

import pandas as pd
import numpy as np


def filter_samples(samples: list[Sample], concept_names: list[str], min_num_nodes: int):
    samples = filter(lambda x: pd.notna(x.target), samples)
    for concept_graph_name in concept_names:
        samples = filter(
            lambda x: x.concept_graph(concept_graph_name).num_nodes > min_num_nodes,
            samples,
        )
    return list(samples)


def filter_mask_objects(mask: np.ndarray, labels: pd.Series, include_labels: list):
    m = labels.isin(include_labels)
    obj_ids = set(labels[m].index.get_level_values("cell_id"))
    mask_objs = set(mask.flatten())
    mask_objs.remove(0)

    for obj in mask_objs - obj_ids:
        mask[mask == obj] = 0

    return mask