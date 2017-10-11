net.Receive("startedPoll", function()
  local pollQuestion = net.ReadString()

  core.panel.createPoll(pollQuestion)
end)
