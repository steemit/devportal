# Tutorial & Recipe Structure

This document describes the general structure of the README.md of each tutorial found in repositories that this site imports into its tutorials section.

If you're contributing a tutorial to one of those repositories, it's much more likely to be accepted if it conforms to these guidelines.

Use [devportal#46](https://github.com/steemit/devportal/issues/46) as partial reference where this doc is ambiguous (referred to after as `46`). 

**Please note that all visible is contained in the STRUCTURE section.**

## PURPOSE
Tutorials must be focused on a specific task, practice, or theory. The consumer of the tutorial should come away with enough knowledge to perform the task, follow the practice, understand the theory.

---

## README.md
Begin `README.md` guidance

### IMAGES
* Should be no more than 800px wide.
* Must go in `${tutorial dir}/images/`
* There should be at least one image per tutorial

### STRUCTURE

#### Top section
There are three elements
1. **Main tutorial title** The title is the topic & focus. Suitable for a table of contents. Use `# <the tutorial name>`
1. **Skill aquired paragraph** Defines clearly the knowledge/skill aquired by successfully 
    completing the tutorial. One sentence long. 
1. **Description paragraph** The description goes into greater detail. It is intended to 
    help the consumer decide if the tutorial is appropriate for consumption. This may 
    include examples of applicability (where the operation(s) in this tutorial would be 
    useful) If there are areas of likely interest that the tutorial does *not* cover, 
    that is explained as well.

#### Intro
* Titled with `## Intro` One  or two paragraphs that give context and background. This 
    section gives users who are interested some of the philosophical points of what the
    tutorial is doing, or should do.


#### LIST OF STEPS/OPERATIONS IN THE TUTORIAL
*   This section is titled `## Steps`
*   If there are 2 or more steps to the tutorial an in-order, 
    titled and numbered list of steps (must use `1.` for each step). 
    A brief description is recommended but not needed. If there are 
    'complication' scenarios as described in 
    [#46](https://github.com/steemit/devportal/issues/46), those are enumerated here.
*   Each step should have its name bolded. And should link to the tutorial step


#### TUTORIAL
* The tutorial in detail, with each step titled & numbered exactly as output in the above section. 
* Tutorial section begins with a horizontal rule `---`. There is no large text



##### TUTORIAL STEP
* Each step describes what happens in that step. 
* Each step should start with `#### <Step Number> <Step Name>`
* A step may be numbered as a "primary" step ex: `1.` or a "secondary" step `1.a.`
* If there is a code-block that the writer feels should be in the "right-code" section of the 
    developer portal, that code-block should be created with `~~~`
    * there may be only one `~~~` code-block per api step (but multiple ` ``` `)
* A step includes no more than one api call 
    * If there is an api call, there is a block with the title "Query" showing 
        the parameters for the call, and at least one block titled "Response" 
        showing a possible response from the api (multiple possible responses may be 
        shown, so long as they are numbered/labels and there are adequate descriptions 
        of each response & why it would be emitted by the API)


##### DONE STATEMENT
* *optional* - a wrapup of some kind.
* A simple, bolded statement telling the consumer they're done.


#### RUN INSTRUCTIONS
* Titled `## To Run` Describes the running environment 
    (may link to external doc for brevity) with the final "run" instruction(s) 
    listed here, as well as any tutorial specific configurations or settings. 
    If the tutorial/recipe does not have runnable code, states that.


#### Troubleshooting - optional
Any issues that may require troubleshooting

#### FOOTNOTES - optional
A section for any caveat, gotchas, references. The `46` _Simple Arguments_, _Advanced Arguments_, & _Expanded Results_ should be able to point to Steem's API specification in the devportal for the relevant calls. If the specification isn't clear enough, it needs to be updated.


### LINGUISTIC PRECISION
It's very important that the tutorials be both accurate and precise in their language.
* a `function` something used within the client
* a `api call`or `rpc` is a call made between the client and the server. Ex in `client.database.call('get_active_votes', [author, permlink])` is an api call and should be referred to in a manner similar to _the rpc `get_active_votes` ..._. When referencing `.call()` it is a function.
* `<a>` tags that take the user to a different page/site should be referred to as links
* `<a>` `<button>` or any other elements that are hooks for javascript should be referred to as **controls** ex: _Clicking the "go back" control will show the article list_.

_this section will require updating as we find other points of ambiguity_


End `README.md` guidance

---

## Active Code / UI

If a tutorial contains an active component, the following apply

* **README.md** connection: Tutorial code should be labeled with the 'Step number' from the readme if possible.
* **Singular UI:** Tutorials that have runnable code should present input elements, output, and errors _in one place_.
* **UI Communication:** The primary interface (whether terminal or webpage) should always provide visible feedback after any operation without additional action by the user. 
    A a minimum response json should be rendered.
    * If rendering feedback in this way is impossible, tutorial should explain why, and where to get feedback.

## Improving Rake Imports

When information about enhancing tutorials via rake-oriented markup becomes available it will be published in this section. 