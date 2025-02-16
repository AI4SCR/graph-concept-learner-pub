rule train_best_concepts:
    input:
        get_best_all_cells_contact,
        get_best_all_cells_radius,
        get_best_all_cells_ERless_contact,
        get_best_all_cells_ERless_radius,
        get_best_endothelial_contact,
        get_best_endothelial_ERless_contact,
        get_best_endothelial_stromal_contact,
        get_best_endothelial_stromal_ERless_contact,
        get_best_endothelial_tumor_contact,
        get_best_endothelial_tumor_ERless_contact,
        get_best_immune_endothelial_ERless_radius,
        get_best_immune_endothelial_radius,
        get_best_immune_ERless_radius,
        get_best_immune_radius,
        get_best_immune_stromal_ERless_radius,
        get_best_immune_stromal_radius,
        get_best_immune_tumor_ERless_radius,
        get_best_immune_tumor_radius,
        get_best_stromal_contact,
        get_best_stromal_ERless_contact,
        get_best_stromal_tumor_contact,
        get_best_stromal_tumor_ERless_contact,
        get_best_tumor_contact,
        get_best_tumor_ERless_contact,
