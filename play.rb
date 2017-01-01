#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require_relative 'mastermind/client'
require_relative 'mastermind/player'

client = Mastermind::Client.new(ENV['email'])
client.reset
player = Mastermind::Player.new(client: client)
player.play
