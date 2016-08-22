defmodule Medium.PostView do
  use Medium.Web, :view

  def author_name(post) do
    case post.user do
      nil -> "Anonymous"
      user -> user.name
    end
  end
end
