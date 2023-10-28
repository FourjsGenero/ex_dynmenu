
PUBLIC TYPE t_dynmenu_option RECORD
       name STRING,
       text STRING,
       icon STRING,
       style STRING
     END RECORD

PUBLIC TYPE t_dynmenu_option_set DYNAMIC ARRAY OF t_dynmenu_option

PRIVATE CONSTANT max_options = 20

PRIVATE CONSTANT nn = "\n\n\n\n"

PUBLIC FUNCTION dynmenu(
    title STRING,
    options t_dynmenu_option_set
) RETURNS INTEGER
    DEFINE x, ml INTEGER
    DEFINE actname, tmp, fn STRING
    IF ui.Interface.getFrontEndName() IN ("GMA","GMI") THEN
       LET fn = "dynmenuf90"
    ELSE
       LET fn = "dynmenuf3"
    END IF
    OPEN WINDOW w_dynmenu WITH FORM fn
         ATTRIBUTES(TEXT=title, STYLE="normal")
    MENU ""
        ON ACTION option1 LET x=1 EXIT MENU
        ON ACTION option2 LET x=2 EXIT MENU
        ON ACTION option3 LET x=3 EXIT MENU
        ON ACTION option4 LET x=4 EXIT MENU
        ON ACTION option5 LET x=5 EXIT MENU
        ON ACTION option6 LET x=6 EXIT MENU
        ON ACTION option7 LET x=7 EXIT MENU
        ON ACTION option8 LET x=8 EXIT MENU
        ON ACTION option9 LET x=9 EXIT MENU
        ON ACTION option10 LET x=10 EXIT MENU
        ON ACTION option11 LET x=11 EXIT MENU
        ON ACTION option12 LET x=12 EXIT MENU
        ON ACTION option13 LET x=13 EXIT MENU
        ON ACTION option14 LET x=14 EXIT MENU
        ON ACTION option15 LET x=15 EXIT MENU
        ON ACTION option16 LET x=16 EXIT MENU
        ON ACTION option17 LET x=17 EXIT MENU
        ON ACTION option18 LET x=18 EXIT MENU
        ON ACTION option19 LET x=19 EXIT MENU
        ON ACTION option20 LET x=20 EXIT MENU
        BEFORE MENU
            FOR x = 1 TO options.getLength()
                IF options[x].text.getLength() > ml THEN
                   LET ml = options[x].text.getLength()
                END IF
            END FOR
            FOR x = 1 TO max_options
                LET actname = SFMT("option%1",x)
                IF x > options.getLength() THEN
                    CALL DIALOG.setActionActive(actname,FALSE)
                    CALL DIALOG.setActionHidden(actname,1)
                    CALL DIALOG.getForm().setElementHidden(actname,1)
                    CALL DIALOG.getForm().setElementText(actname,NULL)
                    CALL DIALOG.getForm().setElementImage(actname,NULL)
                    CALL DIALOG.getForm().setElementStyle(actname,NULL)
                ELSE
                    CALL DIALOG.setActionActive(actname,TRUE)
                    CALL DIALOG.setActionHidden(actname,0)
                    --CALL DIALOG.setActionText(actname,options[x].name)
                    CALL DIALOG.getForm().setElementHidden(actname,0)
                    IF fn != "dynmenuf90" THEN
                       LET tmp = COLUMN (ml-options[x].text.getLength()+1), options[x].text
                    ELSE
                       LET tmp = options[x].text
                    END IF
                    CALL DIALOG.getForm().setElementText(actname,nn||tmp)
                    CALL DIALOG.getForm().setElementImage(actname,options[x].icon)
                    CALL DIALOG.getForm().setElementStyle(actname,options[x].style)
                END IF
            END FOR
    END MENU
    CLOSE WINDOW w_dynmenu
    RETURN x
END FUNCTION

PRIVATE FUNCTION testme(title STRING, options t_dynmenu_option_set)
    DEFINE x INTEGER
    LET x = dynmenu(title,options)
    ERROR SFMT("Selected option: %1",x)
END FUNCTION

FUNCTION main()
    DEFINE x INTEGER
    DEFINE options_1 t_dynmenu_option_set = [
             (name: "procord", text: "Process Order", icon: "fa-cogs", style:"style1"),
             (name: "create", text: "Create", icon: "fa-file-o", style:"style1"),
             (name: "update", text: "Update", icon: "fa-edit", style:"style1"),
             (name: "delete", text: "Delete", icon: "fa-trash-o", style:"style1"),
             (name: "delete_all", text: "Delete All", icon: "fa-trash", style:"style1"),
             (name: "render", text: "Render image", icon: "fa-file-image-o", style:"style1"),
             (name: "remorph", text: "Remove Orphan Topics", icon: "fa-gears", style:"style1"),
             (name: "validate", text: "Validate", icon: "fa-check", style:"style1"),
             (name: "print", text: "Print", icon: "printer", style:"style1"),
             (name: "cancel", text: "Cancel", icon: "cancel", style:"style1")
           ]
    DEFINE options_2 t_dynmenu_option_set = [
             (name: "person1", icon: "face1-01.svg", style:"style2"),
             (name: "person2", icon: "face2-01.svg", style:"style2"),
             (name: "person3", icon: "face3-01.svg", style:"style2"),
             (name: "person4", icon: "face4-01.svg", style:"style2"),
             (name: "person5", icon: "face5-01.svg", style:"style2"),
             (name: "person6", icon: "face6-01.svg", style:"style2"),
             (name: "person7", icon: "face7-01.svg", style:"style2"),
             (name: "person8", icon: "face8-01.svg", style:"style2")
           ]
    DEFINE tmp t_dynmenu_option_set

    MENU "Test"
        COMMAND "Test1"
           CALL testme("Test 1",options_1)
        COMMAND "Test2"
           CALL options_1.copyTo(tmp)
           FOR x=1 TO 3
               CALL tmp.deleteElement(2)
           END FOR
           CALL testme("Test 2",tmp)
        COMMAND "Test3"
           CALL options_1.copyTo(tmp)
           FOR x=1 TO 7
               CALL tmp.deleteElement(2)
           END FOR
           CALL testme("Test 3",tmp)
        COMMAND "Test4"
           CALL testme("Test 4",options_2)
        COMMAND "Exit"
           EXIT MENU
    END MENU

END FUNCTION
