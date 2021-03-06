defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of string representing a stack of plain cards

  ## Example
      iex> Cards.create_deck
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamond",
      "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamond",
      "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamond",
      "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamond",
      "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamond"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles the position of cards in a deck
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Checks if `element` is in `deck` 

  ## Examples
      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, element) do
    Enum.member?(deck, element)
  end

  @doc """
    Devides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex > deck = Cards.create_deck
      iex > {hand, deck} = Cards.deal(deck, 1)
      iex > hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do 
    Enum.split(deck, hand_size);
  end

  def save(deck, filename) do 
    binary = :erlang.term_to_binary(deck);
    File.write(filename, binary)
  end

  def load(filename) do 
    case File.read(filename) do 
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> case reason do 
        :enoent -> "The file does not exist"
        :eacces -> "Missing permission for reading the file, or for searching one of the parent directories"
        :eisdir -> "The named file is a directory"
        :enotdir -> "A component of the file name is not a directory"
        :enomem -> "There is not enough memory for the contents of the file"
      end
    end
  end

  def create_hand(hand_size) do 
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end