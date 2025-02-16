# Train a GNN model specifies by a config, log results and save weights.
rule pretrain_concept:
    input:
        #get_all_graphs_for_a_concept, # Dependence on all graphs.
        mlflow_uri=f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/mlruns/flag.txt",
        cfg=f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/configs/pretrain_model_configs/{{config_id}}.yaml",
        splits=f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/meta_data/CV_folds/folds/{{fold}}.csv",
        concept=f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/processed_data/attributed/{{attribute_config}}/{{concept}}/{{fold}}"
    output:
        f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/checkpoints/single_concepts/{{attribute_config}}/{{concept}}/{{config_id}}/{{labels_permuted}}/{{fold}}/{{seed}}/test_conf_mat_from_best_val_balanced_accuracy.png",
        f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/checkpoints/single_concepts/{{attribute_config}}/{{concept}}/{{config_id}}/{{labels_permuted}}/{{fold}}/{{seed}}/test_conf_mat_from_best_val_weighted_f1_score.png",
        out_files=expand(f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/checkpoints/single_concepts/"+"{{attribute_config}}/{{concept}}/{{config_id}}/{{labels_permuted}}/{{fold}}/{{seed}}/best_val_{metric_name}.pt", metric_name=config["follow_this_metrics"]),
    params:
        normalized_with=normalized_with,
        split_strategy=split_how,
        run_type="pretrain_concept",
        labels_permuted="{labels_permuted}",
        mlflow_on_remote_server=mlflow_on_remote_server,
        seed = "{seed}"
    resources:
        cores="1+1",
        mem="3G",
        queue="x86_1h",
    log:
        f"{root}/prediction_tasks/{prediction_target}/{normalized_with}/logs/pretrain_concept/{{attribute_config}}/{{concept}}/{{config_id}}/{{labels_permuted}}/{{fold}}/{{seed}}"
    shell:
        "source scripts/setup_MLflow.sh {params.mlflow_on_remote_server} && "
        "6_pretrain/scripts/pretrain_concept.py "
        "{input.cfg} {input.splits} {input.concept} "
        "{params.normalized_with} {params.split_strategy} {params.run_type} {params.labels_permuted} "
        "{params.mlflow_on_remote_server} {params.seed} $(dirname {input.mlflow_uri}) "
        "{config[prediction_target]} {config[root]} {config[log_frequency]} "
        "{output.out_files}"
