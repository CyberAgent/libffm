import ffm


def main():
    # Prepare the data. (field, index, value) format
    X = [[(1, 2, 1), (2, 3, 1), (3, 5, 1)],
         [(1, 0, 1), (2, 3, 1), (3, 7, 1)],
         [(1, 1, 1), (2, 3, 1), (3, 7, 1), (3, 9, 1)], ]
    y = [1, 1, 0]
    train_data = ffm.Dataset(X, y)

    # Train FFM model
    model = ffm.train(
        train_data,
        quiet=False
    )
    print("Best iteration:", model.best_iteration)

    # Predict
    x = [(1, 2, 1), (2, 3, 1), (3, 5, 1)]
    pred_y = model.predict(x)
    print(f"Predict result: {pred_y}")

    # Dump model
    with open("./model/prod-cvr.model", 'w') as f:
        model.dump_model(f)


if __name__ == '__main__':
    main()
