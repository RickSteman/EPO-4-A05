classdef GUI_V3_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        EButton                       matlab.ui.control.StateButton
        QButton                       matlab.ui.control.StateButton
        PlotButton                    matlab.ui.control.Button
        WaypointYcoordinateEditField  matlab.ui.control.NumericEditField
        WaypointYcoordinateEditFieldLabel  matlab.ui.control.Label
        WaypointXcoordinateEditField  matlab.ui.control.NumericEditField
        WaypointXcoordinateEditFieldLabel  matlab.ui.control.Label
        WButton                       matlab.ui.control.StateButton
        DButton                       matlab.ui.control.StateButton
        SButton                       matlab.ui.control.StateButton
        AButton                       matlab.ui.control.StateButton
        UIAxes2_3                     matlab.ui.control.UIAxes
        UIAxes2_2                     matlab.ui.control.UIAxes
        UIAxes2                       matlab.ui.control.UIAxes
        UIAxes                        matlab.ui.control.UIAxes
    end


    properties (Access = public)
        x_position = 200;            % The starting position of the dot on x axis
        y_position = 101;            % The starting position of the dot on y axis
        x_start = 200;
        y_start = 101;
        x_box = [100, 700, 700, 100, 100];  % The outside of the arena
        y_box = [100, 100, 700, 700, 100];  % The outside of the arena

        crash = 0;          % Initialize crash as 0

        input_force = 150;  % Force pressed on trigger
        force = 0;          % accelaration force
        direction = 150;    % Direction of wheels
        speed = 0;          % Speed of car
        facing = pi/2;      % Direction the car is facing in rad 0 = x

        s1; s2; s3; s4; s5; s6; s7; s8; s9; s0;
        m = 5.6;
        b = 5;
        c = 0.1;
        x;
        h;
        t;
        tt = 0.1;  % Δt = 0.1 so loop period is set to 0.1 seconds
        now;
        Loop;
        x_distance; y_distance; distance;
        waypoint = 0;
        startTime=0;
        disableW = 0; %used when the dynamic system test is enabled to prevent
    end

    methods (Access = private)

        function collision(app)
            % Checks if the car is outside of the arena
            if (app.x_position >= 700 ) || (app.x_position <= 100) || (app.y_position <= 100) || (app.y_position >= 700)
                app.crash = 1;      % If crashed set crash to 1
                app.speed = 0;
                stop(app.Loop);     % If crashed stop the loop

                % Plot the crash location
                plot(app.UIAxes, app.x_position, app.y_position,'x','MarkerSize', 40, 'color', 'r', 'LineWidth', 2)
            end
        end

        function velocity(app)
            % Speed is calculated in m/s now, so *100 is added on the display in the figure
            app.force = (app.input_force - 150)*2/3;
            app.speed = app.speed + app.force*app.tt/app.m - app.b*app.speed*app.tt/app.m - app.c*app.speed^2*app.tt/app.m;

            %stops the loop when the speed is <1 cm/s to prevent an timer
            %error loop
            if(app.speed < 0.01)  && (app.y_position>110)
                stop(app.Loop);
            end

            %Plot the position, velocity and acceleration
            plot(app.UIAxes2, app.t-app.startTime, app.y_position, 'b.');
            hold(app.UIAxes2, 'on');
            plot(app.UIAxes2_2, app.t-app.startTime, app.speed, 'b.');
            hold(app.UIAxes2_2, 'on');
            plot(app.UIAxes2_3, app.t-app.startTime, app.force/app.m - app.b*app.speed/app.m - app.c*app.speed^2/app.m, 'b.');
            hold(app.UIAxes2_3, 'on');
        end

        function waypointdistance(app)
            % Calculate the distance to the waypoint
            % Only supports 1 waypoint as of now
            app.x_distance = abs(app.WaypointXcoordinateEditField.Value - app.x_position);
            app.y_distance = abs(app.WaypointYcoordinateEditField.Value - app.y_position);
            app.distance = sqrt(app.x_distance^2 + app.y_distance^2);
        end

        %Function to test the dynamic system by accelerating for 2.4
        %seconds and braking for 0.5 seconds. Can be called to test. If not
        %called, the 'w' key on the keyboard can be used to drive forwards.

        function accelerateAndBrake(app)
            app.disableW = 1; %disable movement from the w button
            if  (app.t-app.startTime>0.1) && (app.t-app.startTime<2.5) && (app.startTime~=0)
                app.input_force = 165; %+10N
            elseif(app.t-app.startTime>=2.5) && (app.t-app.startTime<3) && (app.startTime~=0)
                app.input_force =135; %-10N
            else
                app.input_force = 150; %Neutral
            end

        end


        function LoopFcn(app,~,~)

            hold(app.UIAxes,'on')   % Keeps old dot locations and arena

            collision(app);         % Checks every 0.1 seconds if the car has gone outside the arena

            if (app.waypoint >= 1)
                waypointdistance(app);  % Checks every 0.1 seconds the distance to the waypoint if a waypoint is present
            end

            if(app.y_position<=102)
                app.startTime=app.t;
            end

            app.t = toc(app.now);
            app.s1 = sprintf('force: %g N', app.input_force);   %kitt.force
            app.s2 = sprintf('velocity: %g cm/s', app.speed*100);   %kitt.velocity
            app.s3 = sprintf('angle: %g', app.direction);       %kitt.angle
            app.s4 = sprintf('x position: %g  cm', app.x_position);  %kitt.distL
            app.s5 = sprintf('y position: %g cm', app.y_position);   %kitt.distR

            app.s6 = sprintf('time: %0.2f s',app.t-app.startTime);            %time
            app.s7 = sprintf('crash: %g', app.crash);           %carchrash(kitt);
            app.s8 = sprintf('zaps: ');                         %kitt.numzaps;
            app.s9 = sprintf('dist. to wp: %g cm', app.distance);
            app.s0 = sprintf('distanceY: %g cm', (app.y_position-app.y_start));

            delete(app.h);  %delete text before writing it again

            app.h(1) = text(app.UIAxes,500,490,app.s1);
            app.h(2) = text(app.UIAxes,500,470,app.s2);
            app.h(3) = text(app.UIAxes,500,450,app.s3);
            app.h(4) = text(app.UIAxes,500,430,app.s4);
            app.h(5) = text(app.UIAxes,500,410,app.s5);
            app.h(6) = text(app.UIAxes,500,390,app.s6);
            %             app.h(7) = text(app.UIAxes,5,370,app.s7);
            %             app.h(8) = text(app.UIAxes,5,350,app.s8);
            %             app.h(9) = text(app.UIAxes,5,330,app.s9);
            app.h(10) = text(app.UIAxes,500,310,app.s0);

            % Determine new position based on force and angle
            app.facing = app.facing + app.speed*app.tt*tan((app.direction - 150)*0.45/50)/0.335;
            app.x_position = app.x_position + 100*app.speed*app.tt * cos(app.facing); %converted m to cm
            app.y_position = app.y_position + 100*app.speed*app.tt * sin(app.facing); %converted m to cm

            % If statement to prevent plotting another dot outside the arena
            if (app.crash == 0)
                plot(app.UIAxes, app.x_position, app.y_position,'bo');
            end

            %Calculate the next velocity
            velocity(app);

            %Test the dynamic system. May be commented out to use full
            %keyboard functionality
            accelerateAndBrake(app);



            % Clear the WASD control keys from their input
            app.WButton.Value = 0;
            app.AButton.Value = 0;
            app.SButton.Value = 0;
            app.DButton.Value = 0;
            app.EButton.Value = 0;
            app.QButton.Value = 0;
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Gives the right axis' on startup
            app.UIAxes.YLim = [0 800];
            app.UIAxes.XLim = [0 800];
            plot(app.UIAxes, app.x_position, app.y_position,'bo', app.x_box, app.y_box, 'r-');

            % Prints the initial texts in the plot
            app.now = tic;
            app.s1 = sprintf('force: 0 N');
            app.s2 = sprintf('velocity: 0 m/s');
            app.s3 = sprintf('angle: 0 ');
            app.s4 = sprintf('x position: %g  cm', app.x_position);
            app.s5 = sprintf('y position: %g cm', app.y_position);
            app.s6 = sprintf('time: 0 s');

            app.h(1) = text(app.UIAxes,500,490,app.s1);
            app.h(2) = text(app.UIAxes,500,470,app.s2);
            app.h(3) = text(app.UIAxes,500,450,app.s3);
            app.h(4) = text(app.UIAxes,500,430,app.s4);
            app.h(5) = text(app.UIAxes,500,410,app.s5);
            app.h(6) = text(app.UIAxes,500,390,app.s6);

            % Create timer object
            app.Loop = timer(...
                'ExecutionMode', 'fixedRate', ...    % Run timer repeatedly
                'Period', app.tt, ...                % Period of the function
                'BusyMode', 'queue',...              % Queue timer callbacks when busy
                'TimerFcn', @app.LoopFcn);           % Specify callback function

            % Start the loop
            start(app.Loop);
        end

        % Window key press function: UIFigure
        function UIFigureWindowKeyPress(app, event)
            key = event.Key;

            switch key
                case 'a'
                    app.AButton.Value = 1;
                    if (app.y_position <= 700 ) && (app.y_position >= 100) && (app.x_position <= 700 ) && (app.x_position >= 100)
                        if (app.direction < 200)
                            app.direction = app.direction + 2;
                        end
                    end
                case 'w'

                    if (app.y_position <= 700 ) && (app.y_position >= 100) && (app.x_position <= 700 ) && (app.x_position >= 100)
                        if (app.input_force < 165) && app.disableW == 0;
                            app.input_force = app.input_force + 1;
                        end

                        app.WButton.Value = 1;
                    end
                case 's'
                    app.SButton.Value = 1;
                    if (app.y_position <= 700 ) && (app.y_position >= 100) && (app.x_position <= 700 ) && (app.x_position >= 100)
                        if (app.input_force > 135)
                            app.input_force = app.input_force - 1;
                        end
                    end
                case 'd'
                    app.DButton.Value = 1;
                    if (app.y_position <= 700 ) && (app.y_position >= 100) && (app.x_position <= 700 ) && (app.x_position >= 100)
                        if (app.direction > 100)
                            app.direction = app.direction - 2;
                        end
                    end
                case 'e'                        % E brake
                    app.EButton.Value = 1;
                    if (app.y_position <= 700 ) && (app.y_position >= 100) && (app.x_position <= 700 ) && (app.x_position >= 100)
                        app.input_force = 150;
                    end
                case 'q'                        % Pulls the car straight
                    app.QButton.Value = 1;
                    if (app.y_position <= 700 ) && (app.y_position >= 100) && (app.x_position <= 700 ) && (app.x_position >= 100)
                        app.direction = 150;
                    end

                    %--------------------------------------------------------------------------------%
                    % Space function is very messy now and not how it should be, needs to be revised %
                    %--------------------------------------------------------------------------------%

                case 'space'
                    app.UIAxes.cla;
                    app.input_force = 150;     % reset to initial values
                    app.direction = 150; % reset to initial values
                    app.facing = pi/2;    % reset to initial values
                    app.x_position = 200; % reset to start
                    app.y_position = 101; % reset to start

                    plot(app.UIAxes, app.x_position, app.y_position,'bo', app.x_box, app.y_box, 'r-');
                    app.crash = 0;

                    app.now = tic;
                    app.s1 = sprintf('force: 0 N');
                    app.s2 = sprintf('velocity: 0 m/s');
                    app.s3 = sprintf('angle: 0 ');
                    app.s4 = sprintf('x position: %g  cm', app.x_position);
                    app.s5 = sprintf('y position: %g cm', app.y_position);
                    app.s6 = sprintf('time: 0 s');
                    app.s7 = sprintf('crash: %g', app.crash);         %carchrash(kitt);
                    app.s8 = sprintf('zaps: ');          %kitt.numzaps;

                    app.h(1) = text(app.UIAxes,500,490,app.s1);
                    app.h(2) = text(app.UIAxes,500,470,app.s2);
                    app.h(3) = text(app.UIAxes,500,450,app.s3);
                    app.h(4) = text(app.UIAxes,500,430,app.s4);
                    app.h(5) = text(app.UIAxes,500,410,app.s5);
                    app.h(6) = text(app.UIAxes,500,390,app.s6);
                    app.h(7) = text(app.UIAxes,500,370,app.s7);
                    app.h(8) = text(app.UIAxes,500,350,app.s8);
            end
        end

        % Callback function: PlotButton, UIAxes2
        function PlotButtonPushed(app, event)
            app.waypoint = app.waypoint + 1;
            plot(app.UIAxes, app.WaypointXcoordinateEditField.Value, app.WaypointYcoordinateEditField.Value, '.' ,'MarkerSize', 15, 'color', 'g')
        end

        % Callback function
        function UIAxes2ButtonDown(app, event)
            %             plot(app.UIAxes2, app.startTime, app.speed, '.' ,'MarkerSize', 15, 'color', 'g');
        end

        % Button down function: UIAxes2_2
        function UIAxes2_2ButtonDown(app, event)

        end

        % Button down function: UIAxes2_3
        function UIAxes2_3ButtonDown(app, event)

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1251 803];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.WindowKeyPressFcn = createCallbackFcn(app, @UIFigureWindowKeyPress, true);

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            app.UIAxes.Position = [129 124 776 666];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Position')
            xlabel(app.UIAxes2, 'Time (s)')
            ylabel(app.UIAxes2, 'Position (m)')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.ButtonDownFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.UIAxes2.Position = [904 584 300 185];

            % Create UIAxes2_2
            app.UIAxes2_2 = uiaxes(app.UIFigure);
            title(app.UIAxes2_2, 'Velocity')
            xlabel(app.UIAxes2_2, 'Time (s)')
            ylabel(app.UIAxes2_2, 'Velocity (m/s)')
            zlabel(app.UIAxes2_2, 'Z')
            app.UIAxes2_2.ButtonDownFcn = createCallbackFcn(app, @UIAxes2_2ButtonDown, true);
            app.UIAxes2_2.Position = [904 380 300 185];

            % Create UIAxes2_3
            app.UIAxes2_3 = uiaxes(app.UIFigure);
            title(app.UIAxes2_3, 'Acceleration')
            xlabel(app.UIAxes2_3, 'Time (s)')
            ylabel(app.UIAxes2_3, 'Acceleration (m/s^2)')
            zlabel(app.UIAxes2_3, 'Z')
            app.UIAxes2_3.ButtonDownFcn = createCallbackFcn(app, @UIAxes2_3ButtonDown, true);
            app.UIAxes2_3.Position = [904 184 300 185];

            % Create AButton
            app.AButton = uibutton(app.UIFigure, 'state');
            app.AButton.Text = 'A';
            app.AButton.Position = [194 40 32 32];

            % Create SButton
            app.SButton = uibutton(app.UIFigure, 'state');
            app.SButton.Text = 'S';
            app.SButton.Position = [225 40 32 32];

            % Create DButton
            app.DButton = uibutton(app.UIFigure, 'state');
            app.DButton.Text = 'D';
            app.DButton.Position = [256 40 32 32];

            % Create WButton
            app.WButton = uibutton(app.UIFigure, 'state');
            app.WButton.Text = 'W';
            app.WButton.Position = [225 71 32 32];

            % Create WaypointXcoordinateEditFieldLabel
            app.WaypointXcoordinateEditFieldLabel = uilabel(app.UIFigure);
            app.WaypointXcoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.WaypointXcoordinateEditFieldLabel.Position = [663 92 127 22];
            app.WaypointXcoordinateEditFieldLabel.Text = 'Waypoint X-coordinate';

            % Create WaypointXcoordinateEditField
            app.WaypointXcoordinateEditField = uieditfield(app.UIFigure, 'numeric');
            app.WaypointXcoordinateEditField.Position = [805 92 100 22];

            % Create WaypointYcoordinateEditFieldLabel
            app.WaypointYcoordinateEditFieldLabel = uilabel(app.UIFigure);
            app.WaypointYcoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.WaypointYcoordinateEditFieldLabel.Position = [665 59 125 22];
            app.WaypointYcoordinateEditFieldLabel.Text = 'Waypoint Y-coordinate';

            % Create WaypointYcoordinateEditField
            app.WaypointYcoordinateEditField = uieditfield(app.UIFigure, 'numeric');
            app.WaypointYcoordinateEditField.Position = [805 59 100 22];

            % Create PlotButton
            app.PlotButton = uibutton(app.UIFigure, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.Position = [780 27 55 22];
            app.PlotButton.Text = 'Plot';

            % Create QButton
            app.QButton = uibutton(app.UIFigure, 'state');
            app.QButton.Text = 'Q';
            app.QButton.Position = [163 82 32 32];

            % Create EButton
            app.EButton = uibutton(app.UIFigure, 'state');
            app.EButton.Text = 'E';
            app.EButton.Position = [287 82 32 32];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GUI_V3_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end