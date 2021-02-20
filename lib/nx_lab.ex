defmodule NxLab do
  @moduledoc """
  Documentation for `NxLab`.
  """

  def run do
    <<_::32, n_images::32, n_rows::32, n_cols::32, images::binary>> =
      "data/train-images-idx3-ubyte.gz"
      |> File.read!()
      |> :zlib.gunzip()

    # heatmap =
    #   images
    #   |> Nx.from_binary({:u, 8})
    #   |> Nx.reshape({n_images, n_rows, n_cols})
    #   |> Nx.to_heatmap()

    # IO.inspect heatmap, label: "heatmap"

    images =
      images
      |> Nx.from_binary({:u, 8})
      |> Nx.reshape({n_images, n_rows * n_cols}, names: [:batch, :input])
      |> Nx.divide(255)
      |> Nx.to_batched_list(30)

    <<_::32, n_labels::32, labels::binary>> =
      "data/train-labels-idx1-ubyte.gz"
      |> File.read!()
      |> :zlib.gunzip()

    labels =
      labels
      |> Nx.from_binary({:u, 8})
      |> Nx.reshape({n_labels, 1}, names: [:batch, :output])
      |> Nx.equal(Nx.tensor(Enum.to_list(0..9)))
      |> Nx.to_batched_list(30)

    # IO.inspect images, label: "images"
    # IO.inspect n_labels, label: "n_labels"
    # IO.inspect labels, label: "labels"

    [fbi | _] = images
    # IO.inspect fbi, label: "first batch"

    MNIST.predict(MNIST.init_params(), fbi[0..2])

    zip = Enum.zip(images, labels) |> Enum.with_index()

    params =
      for e <- 1..5,
        {{images, labels}, b} <- zip,
        reduce: MNIST.init_params() do

        params ->
          IO.puts "epoch #{e}, batch #{b}"
          MNIST.update(params, images, labels)
      end

    # IO.inspect params, label: "PARAMS"

    MNIST.predict(params, fbi[0..2])
  end
end
