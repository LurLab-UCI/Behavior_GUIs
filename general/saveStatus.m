  function saveStatus(app,fn)
            
    h = findobj(app.figure1,'Type','uicheckbox');
    xarr = zeros(length(h),1);
    for i = 1:length(h)
       xarr(i) = h(i).Value;
    end
    state.checkboxes = xarr;

     h = findobj(app.figure1,'Type','uieditfield');
     for i = 1:length(h)
        xa{i} = h(i).Value;
     end
     %state.editfields = xa;

     h = findobj(app.figure1,'Type','uinumericeditfield');
     for i = 1:length(h)
        xa{i} = h(i).Value;
     end
     state.uinumericeditfields = xa;

     h = findobj(app.figure1,'Type','uiradiobutton');
     for i = 1:length(h)
        xa{i} = h(i).Value;
     end
     state.uiradiobuttons = xa;

     h = findobj(app.figure1,'Type','uiDropDown');
     for i = 1:length(h)
        xa{i} = h(i).Value;
     end
     state.dropdowns = xa;
     

   ps = app.figure1.Position;
   save(fn,'state','ps');

  end