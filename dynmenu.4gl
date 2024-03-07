
PUBLIC TYPE t_dynmenu_option RECORD
       oname STRING,
       otext STRING,
       oicon STRING,
       ostyle STRING
     END RECORD

PUBLIC TYPE t_dynmenu_option_set DYNAMIC ARRAY OF t_dynmenu_option

PRIVATE CONSTANT max_options = 20

PRIVATE CONSTANT nn = "\n\n\n\n"

PUBLIC FUNCTION dynmenu(
    mtit STRING,
    opts t_dynmenu_option_set
) RETURNS INTEGER
    DEFINE x, ml INTEGER
    DEFINE actname, tmp, fn STRING
    IF ui.Interface.getFrontEndName() IN ("GMA","GMI") THEN
       LET fn = "dynmenuf90"
    ELSE
       LET fn = "dynmenuf3"
    END IF
    OPEN WINDOW w_dynmenu WITH FORM fn
         ATTRIBUTES(TEXT=mtit, STYLE="normal")
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
            FOR x = 1 TO opts.getLength()
                IF opts[x].otext.getLength() > ml THEN
                   LET ml = opts[x].otext.getLength()
                END IF
            END FOR
            FOR x = 1 TO max_options
                LET actname = SFMT("option%1",x)
                IF x > opts.getLength() THEN
                    CALL DIALOG.setActionActive(actname,FALSE)
                    CALL DIALOG.setActionHidden(actname,1)
                    CALL DIALOG.getForm().setElementHidden(actname,1)
                    CALL DIALOG.getForm().setElementText(actname,NULL)
                    CALL DIALOG.getForm().setElementImage(actname,NULL)
                    CALL DIALOG.getForm().setElementStyle(actname,NULL)
                ELSE
                    CALL DIALOG.setActionActive(actname,TRUE)
                    CALL DIALOG.setActionHidden(actname,0)
                    --CALL DIALOG.setActionText(actname,opts[x].oname)
                    CALL DIALOG.getForm().setElementHidden(actname,0)
                    IF fn != "dynmenuf90" THEN
                       LET tmp = COLUMN (ml-opts[x].otext.getLength()+1), opts[x].otext
                    ELSE
                       LET tmp = opts[x].otext
                    END IF
                    CALL DIALOG.getForm().setElementText(actname,nn||tmp)
                    CALL DIALOG.getForm().setElementImage(actname,opts[x].oicon)
                    CALL DIALOG.getForm().setElementStyle(actname,opts[x].ostyle)
                END IF
            END FOR
    END MENU
    CLOSE WINDOW w_dynmenu
    RETURN x
END FUNCTION

PRIVATE FUNCTION testme(mtit STRING, opts t_dynmenu_option_set)
    DEFINE x INTEGER
    LET x = dynmenu(mtit,opts)
    ERROR SFMT("Selected option: %1",x)
END FUNCTION

FUNCTION main()
    DEFINE x INTEGER
    DEFINE options_1 t_dynmenu_option_set = [
             (oname: "procord",    otext: "Process Order",  oicon: "fa-cogs",         ostyle:"style1"),
             (oname: "create",     otext: "Create",         oicon: "fa-file-o",       ostyle:"style1"),
             (oname: "update",     otext: "Update",         oicon: "fa-edit",         ostyle:"style1"),
             (oname: "delete",     otext: "Delete",         oicon: "fa-trash-o",      ostyle:"style1"),
             (oname: "delete_all", otext: "Delete All",     oicon: "fa-trash",        ostyle:"style1"),
             (oname: "render",     otext: "Render image",   oicon: "fa-file-image-o", ostyle:"style1"),
             (oname: "remorph",    otext: "Remove Orphans", oicon: "fa-gears",        ostyle:"style1"),
             (oname: "validate",   otext: "Validate",       oicon: "fa-check",        ostyle:"style1"),
             (oname: "print",      otext: "Print",          oicon: "printer",         ostyle:"style1"),
             (oname: "cancel",     otext: "Cancel",         oicon: "cancel",          ostyle:"style1")
           ]
    DEFINE options_2 t_dynmenu_option_set = [
             (oname: "person1", oicon: "face1-01.svg", ostyle:"style2"),
             (oname: "person2", oicon: "face2-01.svg", ostyle:"style2"),
             (oname: "person3", oicon: "face3-01.svg", ostyle:"style2"),
             (oname: "person4", oicon: "face4-01.svg", ostyle:"style2"),
             (oname: "person5", oicon: "face5-01.svg", ostyle:"style2"),
             (oname: "person6", oicon: "face6-01.svg", ostyle:"style2"),
             (oname: "person7", oicon: "face7-01.svg", ostyle:"style2"),
             (oname: "person8", oicon: "face8-01.svg", ostyle:"style2")
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
