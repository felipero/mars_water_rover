%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/"],
        excluded: []
      },
      checks: [
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Warning.LazyLogging, false}
        # {Credo.Check.Consistency.TabsOrSpaces},
        # {Credo.Check.Readability.MaxLineLength, priority: :low, max_length: 110}
      ]
    }
  ]
}
