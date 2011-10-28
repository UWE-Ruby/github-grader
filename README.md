# Github Grader

This tool will download a specified repository for an organization's team and run the tests to ensure that all the assignments have been started and completed.

## Execution

```
rake
```

The tool will prompt you for your github username and password so that it can get the list of the individuals in the UWE-Ruby course. 

Then you need to specify the assignment that you want to grade. Essentially specially the repo `week-01`, `week-02`. At that point it will quickly move through all the participants on the Fall Team cloning their repos and executing the tests.

### Notes

## Assumptions

* Currently this is hard-coded specifically to the fall class of the UWE-Ruby
* All participants present on the team are examined (some people might not be engaging in the exercises)
* Assumes that the team members all have repository with the same name (forked from the original and maintained the same name).
* Runs `rpsec spec` to capture the results (instead of calling rake; as the rake tasks did not return the value when they were done executing)
* That the gems are currently installed correctly for the assignment

## Limitations

* Login is required to get a list of the participants
* Does not generate any documentation about the execution.
* Purposefully leaves folders around of the students that have not finished their work for this documentation
* Github names are not mapped to the student's email / names in the classroom
* Forked output is not attractive to view