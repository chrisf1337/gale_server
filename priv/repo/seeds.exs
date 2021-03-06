# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GaleServer.Repo.insert!(%GaleServer.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GaleServer.{Repo, User, Friend, FriendReq, Event, AcceptedEventUser,
  PendingEventUser, RejectedEventUser}
alias Ecto.Changeset

Repo.delete_all(Event)
Repo.delete_all(User)

assert = fn (c) -> if not c do throw(c) end end

assert.(length(Repo.all(Friend)) == 0)
assert.(length(Repo.all(FriendReq)) == 0)
assert.(length(Repo.all(AcceptedEventUser)) == 0)
assert.(length(Repo.all(RejectedEventUser)) == 0)
assert.(length(Repo.all(PendingEventUser)) == 0)

adam = Repo.insert! User.changeset(%User{},
  %{username: "adam", name: "adam", password: "adampass"})
bob = Repo.insert! User.changeset(%User{},
  %{username: "bob", name: "bob", password: "bobpass"})
chris = Repo.insert! User.changeset(%User{},
  %{username: "chris", name: "chris", password: "pass"})
dan = Repo.insert! User.changeset(%User{},
  %{username: "dan", name: "dan", password: "danpass"})
dan2 = Repo.insert! User.changeset(%User{},
  %{username: "dan2", name: "dan", password: "danpass"})
Repo.insert! FriendReq.changeset(%FriendReq{},
  %{user_id: chris.id, friend_id: adam.id})
Repo.insert! Friend.changeset(%Friend{},
  %{user_id: bob.id, friend_id: chris.id})
Repo.insert! Friend.changeset(%Friend{},
  %{user_id: chris.id, friend_id: bob.id})

event = Repo.insert! Event.changeset(%Event{}, %{owner_id: chris.id,
  description: "An event!", time: Timex.now})
Repo.insert! AcceptedEventUser.changeset(%AcceptedEventUser{}, %{user_id: adam.id,
  event_id: event.id})
Repo.insert! PendingEventUser.changeset(%PendingEventUser{}, %{user_id: bob.id,
  event_id: event.id})
Repo.insert! RejectedEventUser.changeset(%RejectedEventUser{}, %{user_id: dan.id,
  event_id: event.id})
