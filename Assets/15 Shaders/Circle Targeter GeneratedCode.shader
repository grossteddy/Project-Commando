Shader "Circle Targeter GeneratedCode"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 0.1686275)
        Vector1_E4CC2161("Edge Width", Range(0, 0.1)) = 0.01
        Vector1_9484AAD8("Top Radius", Range(0.5, 1)) = 0.5
        Vector1_E3065A85("Edges Radius", Range(0, 1)) = 0.9
        Vector1_1CCA8F0E("Outline Width", Range(0.001, 0.5)) = 0.3
        Vector1_4B8F027D("Inner Circle Radius", Float) = 0.15
        Vector1_75F6D1B8("Inner Circle Hardness", Range(0, 1)) = 1
        Vector2_9DCA9D56("_debug", Vector) = (0, 0, 0, 0)
        Vector2_1EEA0460("_debug2", Vector) = (0, 0, 0, 0)
        _Deviation("Deviation", Float) = 0
        [HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
	        "RenderPipeline" = "UniversalPipeline"
            "RenderType" = "Transparent"
            "Queue" = "Transparent+0"
            "UniversalMaterialType" = "Unlit"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalUnlitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                // LightMode: <None>
            }
        
        // Render State
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma shader_feature _ _SAMPLE_GI
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_UNLIT
        #define _FOG_FRAGMENT 1
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 texCoord0;
             float3 viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float3 interp3 : INTERP3;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.texCoord0;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.texCoord0 = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.BaseColor = (_Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0.xyz);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/UnlitPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormalsOnly"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.tangentWS;
            output.interp2.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.tangentWS = input.interp1.xyzw;
            output.texCoord0 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Unlit"
            "Queue"="Transparent"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalUnlitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                // LightMode: <None>
            }
        
        // Render State
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma shader_feature _ _SAMPLE_GI
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_UNLIT
        #define _FOG_FRAGMENT 1
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 texCoord0;
             float3 viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float3 interp1 : INTERP1;
             float4 interp2 : INTERP2;
             float3 interp3 : INTERP3;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.texCoord0;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.texCoord0 = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.BaseColor = (_Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0.xyz);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/UnlitPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormalsOnly"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.tangentWS;
            output.interp2.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.tangentWS = input.interp1.xyzw;
            output.texCoord0 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormalsOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // DotsInstancingOptions: <None>
        // HybridV1InjectedBuiltinProperties: <None>
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #define _SURFACE_TYPE_TRANSPARENT 1
        #define _ALPHATEST_ON 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float Vector1_E4CC2161;
        float Vector1_9484AAD8;
        float Vector1_E3065A85;
        float Vector1_1CCA8F0E;
        float Vector1_4B8F027D;
        float Vector1_75F6D1B8;
        float2 Vector2_9DCA9D56;
        float2 Vector2_1EEA0460;
        float _Deviation;
        CBUFFER_END
        
        // Object and Global properties
        float _ArchAngle;
        float _ArrayCount;
        float _Range;
        
        // Graph Includes
        #include "Assets/15 Shaders/Targeter_Array.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Remap_float2(float2 In, float2 InMinMax, float2 OutMinMax, out float2 Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void SphereMask_float2(float2 Coords, float2 Center, float Radius, float Hardness, out float2 Out)
        {
            Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));
        }
        
        void Unity_OneMinus_float2(float2 In, out float2 Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A - B;
        }
        
        void Unity_Ceiling_float2(float2 In, out float2 Out)
        {
            Out = ceil(In);
        }
        
        void Unity_Maximum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = max(A, B);
        }
        
        void Unity_Smoothstep_float2(float2 Edge1, float2 Edge2, float2 In, out float2 Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Arctangent2_float(float A, float B, out float Out)
        {
            Out = atan2(A, B);
        }
        
        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }
        
        void Unity_Length_float2(float2 In, out float Out)
        {
            Out = length(In);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _UV_60a0f13acf1eb6839902513b2e966c24_Out_0 = IN.uv0;
            float _Split_d632be8752598b8c80af955685359c0d_R_1 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[0];
            float _Split_d632be8752598b8c80af955685359c0d_G_2 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[1];
            float _Split_d632be8752598b8c80af955685359c0d_B_3 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[2];
            float _Split_d632be8752598b8c80af955685359c0d_A_4 = _UV_60a0f13acf1eb6839902513b2e966c24_Out_0[3];
            float2 _Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0 = float2(_Split_d632be8752598b8c80af955685359c0d_R_1, _Split_d632be8752598b8c80af955685359c0d_G_2);
            float2 _Remap_a3f21e2228984980a092541aa51c717c_Out_3;
            Unity_Remap_float2(_Vector2_f6af6e7ecd7aae88a9b7aa7c045537ea_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a3f21e2228984980a092541aa51c717c_Out_3);
            float _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0 = _Deviation;
            float4 _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4;
            float3 _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5;
            float2 _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6;
            Unity_Combine_float(0, _Property_c9cf51c1b1e8998cb87a557b033fe74e_Out_0, 0, 0, _Combine_86af667cc7ad698faae527d5bab81cb9_RGBA_4, _Combine_86af667cc7ad698faae527d5bab81cb9_RGB_5, _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6);
            float2 _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3;
            Unity_TilingAndOffset_float(_Remap_a3f21e2228984980a092541aa51c717c_Out_3, float2 (1, 1), _Combine_86af667cc7ad698faae527d5bab81cb9_RG_6, _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3);
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[0];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2 = _TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3[1];
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_B_3 = 0;
            float _Split_5a10b38ed8179088ac6534b5b888f0bd_A_4 = 0;
            float _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2;
            Unity_Step_float(0, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Step_af7b8350ec3b6587937bc04a86c5352b_Out_2);
            float _Property_61302b43f58fd58a94439aa40d5550c0_Out_0 = _ArchAngle;
            float _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0 = _Deviation;
            float _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2;
            Unity_Subtract_float(2, _Property_eaa8712c147a8f8cb2429f9d330dac0e_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2);
            float _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2;
            Unity_Multiply_float_float(_Property_61302b43f58fd58a94439aa40d5550c0_Out_0, _Subtract_72f7d41b55b7bd80ba1fadce32463e09_Out_2, _Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2);
            float _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2;
            Unity_Divide_float(_Multiply_31017eeea1fd518b9da1ae3ca2db337b_Out_2, 360, _Divide_7238b4520e22b686b5a374dc4adfe408_Out_2);
            float Constant_7d736d43adf3948195d157b0554b9b3b = 3.141593;
            float _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2;
            Unity_Multiply_float_float(_Divide_7238b4520e22b686b5a374dc4adfe408_Out_2, Constant_7d736d43adf3948195d157b0554b9b3b, _Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2);
            float _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1;
            Unity_Cosine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1);
            float _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2;
            Unity_Multiply_float_float(_Cosine_3e41883febf6cb8bac1015ca3e10cbf6_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2);
            float _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1;
            Unity_Sine_float(_Multiply_7c4aff8f1d48e384b0782421884010ec_Out_2, _Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1);
            float _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2;
            Unity_Multiply_float_float(_Sine_5386da5c1803d78bbb73ef5b2d7ecf70_Out_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2);
            float _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2;
            Unity_Subtract_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2);
            float _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2;
            Unity_Multiply_float_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _Subtract_39a8dcf0e5fc558cade484ffe418d146_Out_2, _Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2);
            float _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1;
            Unity_OneMinus_float(_Step_af7b8350ec3b6587937bc04a86c5352b_Out_2, _OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1);
            float _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2;
            Unity_Multiply_float_float(_Multiply_a06eacc2b2cb6286af409b1f56639ec7_Out_2, -1, _Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2);
            float _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2;
            Unity_Subtract_float(_Multiply_1a0efaa14d509f829fc4884a480f06ab_Out_2, _Multiply_bb80d2de356d4e8283b54e7341067d71_Out_2, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2);
            float _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2;
            Unity_Multiply_float_float(_OneMinus_06e1cf86465b3a80bdb59264ae17d0bc_Out_1, _Subtract_ed2b7b51f9b1fe86b86449c6bbb4cbd4_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2);
            float _Add_d2b98180a612e185b742da4ea8383bc7_Out_2;
            Unity_Add_float(_Multiply_39a3d93f740f268d855af398b4b5deaa_Out_2, _Multiply_4cfdcb12905375899ac1ff64655de5fe_Out_2, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2);
            float _Property_ffc45e00f43fe78089d1a0b978980d64_Out_0 = Vector1_E3065A85;
            float _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1;
            Unity_OneMinus_float(_Property_ffc45e00f43fe78089d1a0b978980d64_Out_0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2;
            Unity_Add_float(_Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1, _Add_116c5edd975f1c89a216ea1c769f9dac_Out_2);
            float2 _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0 = float2(0, _OneMinus_737b9bd8de46eb86991e462a6bf10c22_Out_1);
            float _Remap_ad320401fc69808a97806ddc81def0da_Out_3;
            Unity_Remap_float(_Add_116c5edd975f1c89a216ea1c769f9dac_Out_2, _Vector2_4a646a71d1e12c8cb08c63dcda9119b6_Out_0, float2 (0, 1), _Remap_ad320401fc69808a97806ddc81def0da_Out_3);
            float4 _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0 = IN.uv0;
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_R_1 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[0];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[1];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_B_3 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[2];
            float _Split_5c6ef14f65f9518fbc42219f62b69df5_A_4 = _UV_22dc09c25bd70c8094c1de9e653f6de7_Out_0[3];
            float2 _Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0 = float2(_Split_5c6ef14f65f9518fbc42219f62b69df5_R_1, _Split_5c6ef14f65f9518fbc42219f62b69df5_G_2);
            float2 _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3;
            Unity_Remap_float2(_Vector2_e5a649406e0b428ea512ac0a246a0bd8_Out_0, float2 (0, 1), float2 (-1, 1), _Remap_a750c2c44aae60819e23ba15db6f5073_Out_3);
            float _Property_b699560df41b5588a317b09cb72d38fb_Out_0 = _Range;
            float2 _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, 1, _SphereMask_523b028e31e02e86a604f532febfda9b_Out_4);
            float2 _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1;
            Unity_OneMinus_float2(_SphereMask_523b028e31e02e86a604f532febfda9b_Out_4, _OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1);
            float _Property_59df0600501bd389a6a971165affd4fb_Out_0 = Vector1_9484AAD8;
            float2 _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_b699560df41b5588a317b09cb72d38fb_Out_0, _Property_59df0600501bd389a6a971165affd4fb_Out_0, _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4);
            float2 _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1;
            Unity_OneMinus_float2(_SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1);
            float2 _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2;
            Unity_Subtract_float2(_OneMinus_ed1f10d3ed629d8c973ac91607ada93f_Out_1, _OneMinus_0d254a3a8610908bacea6161f85935d8_Out_1, _Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2);
            float2 _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1;
            Unity_OneMinus_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1);
            float2 _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1;
            Unity_Ceiling_float2(_Subtract_0e84f9e1da4b9080b81b4f94c01fc09e_Out_2, _Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1);
            float2 _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1;
            Unity_OneMinus_float2(_Ceiling_cc69aa067802db8a90937ec9d1804f49_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1);
            float2 _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2;
            Unity_Subtract_float2(_OneMinus_9b40e2e3c0298f8482fe2d5761a11ab8_Out_1, _OneMinus_19bc7b0e34699e81855952d8d2115ee4_Out_1, _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2);
            float2 _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2;
            Unity_Maximum_float2((_Remap_ad320401fc69808a97806ddc81def0da_Out_3.xx), _Subtract_6e5c8a25a4b6258b9e96a3518fd2e526_Out_2, _Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2);
            float2 _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3;
            Unity_Smoothstep_float2(float2(0, 0), float2(0.01, 0.11), _SphereMask_7c0cdbf82d7b8a8291b19719abb4fb3f_Out_4, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3);
            float2 _Multiply_209cb70501944780aacb4a667037ddf2_Out_2;
            Unity_Multiply_float2_float2(_Maximum_d7e36ed58944008fb85d17f950a3bf8b_Out_2, _Smoothstep_71df2314f176f782b14e8d09995987c1_Out_3, _Multiply_209cb70501944780aacb4a667037ddf2_Out_2);
            float _Property_8e39c6341e688e84a2fe54549f93dedd_Out_0 = Vector1_E4CC2161;
            float _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2;
            Unity_Multiply_float_float(_Property_8e39c6341e688e84a2fe54549f93dedd_Out_0, -1, _Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2);
            float _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3;
            Unity_Smoothstep_float(_Multiply_11fd38c73606f58a8f6c55e88b9f4857_Out_2, 0, _Add_d2b98180a612e185b742da4ea8383bc7_Out_2, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3);
            float _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2;
            Unity_Multiply_float_float(5, _Smoothstep_6d4b074ae5007f8c8d02d72e7aaa8fe6_Out_3, _Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2);
            float _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1;
            Unity_OneMinus_float(_Multiply_ff7e4f65991dad8aaa66b4edc70a9807_Out_2, _OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1);
            float2 _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2;
            Unity_Multiply_float2_float2(_Multiply_209cb70501944780aacb4a667037ddf2_Out_2, (_OneMinus_ec9300ab6d37518488744f52b2c0d15e_Out_1.xx), _Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2);
            float _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0 = Vector1_E4CC2161;
            float _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2;
            Unity_Arctangent2_float(_Split_5a10b38ed8179088ac6534b5b888f0bd_R_1, _Split_5a10b38ed8179088ac6534b5b888f0bd_G_2, _Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2);
            float2 _Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0 = float2(-1, 1);
            float Constant_57c5815866dfcd888fb8c3956a945444 = 3.141593;
            float2 _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2;
            Unity_Multiply_float2_float2(_Vector2_589ef9a5577f2083950f0aef4d2e0d18_Out_0, (Constant_57c5815866dfcd888fb8c3956a945444.xx), _Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2);
            float _Property_14eb2bc6d36d0488a43777757e544778_Out_0 = _ArchAngle;
            float2 _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2;
            Unity_Multiply_float2_float2(_Multiply_4b3ad9c153d74281af38efcb43b20cf9_Out_2, (_Property_14eb2bc6d36d0488a43777757e544778_Out_0.xx), _Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2);
            float _Float_8607e21279cb9c899ee2a2c429adf354_Out_0 = 180;
            float2 _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2;
            Unity_Divide_float2(_Multiply_e5d2089d9c731b82812aa734ccbc580c_Out_2, (_Float_8607e21279cb9c899ee2a2c429adf354_Out_0.xx), _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2);
            float _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0 = _ArrayCount;
            float2 _Vector2_01f9bde5da8004889906b12bcc793871_Out_0 = float2(0, _Property_cd0ee032dbfb898bb11dc811addc6225_Out_0);
            float _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3;
            Unity_Remap_float(_Arctangent2_f8566d48f060ad829423d4396ef38b5d_Out_2, _Divide_ec125319d915cf86a32d4a080c286bbd_Out_2, _Vector2_01f9bde5da8004889906b12bcc793871_Out_0, _Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3);
            float _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1;
            TargeterArray_float(_Remap_f2b33306eb1bf284a2ca3b8c1576f4f3_Out_3, _TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1);
            float _Property_840741f1bc4b8285adfe09c28358c81f_Out_0 = _Deviation;
            float _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2;
            Unity_Add_float(_TargeterArrayCustomFunction_af48878a4f6c1884b471235f7d009354_distance_1, _Property_840741f1bc4b8285adfe09c28358c81f_Out_0, _Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2);
            float _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1;
            Unity_Length_float2(_TilingAndOffset_54e45266b398118faa7a5fa05daa2c32_Out_3, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1);
            float _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2;
            Unity_Step_float(_Add_1bff9ee5c976a08e8c2c5eaef8655479_Out_2, _Length_8591eedee88d5d83b8287f5bc93de11d_Out_1, _Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2);
            float _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1;
            Unity_OneMinus_float(_Step_c7d68d7d5803de87879c48e6ee1e11b4_Out_2, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1);
            float _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3;
            Unity_Smoothstep_float(0, _Property_559cbaf7d0da9f8d9a1b42f3b2e74cae_Out_0, _OneMinus_e11f59c9a4350d809bf94b7c7f62bbe5_Out_1, _Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3);
            float _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1;
            Unity_OneMinus_float(_Smoothstep_c3ddf067f2bf888fbc9e5929b3d96339_Out_3, _OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1);
            float2 _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2;
            Unity_Subtract_float2(_Multiply_2573e12643a0c18693e37e44bd67d55a_Out_2, (_OneMinus_3986ca588e929784a307a4e19c3124ec_Out_1.xx), _Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2);
            float _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0 = Vector1_4B8F027D;
            float _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0 = Vector1_75F6D1B8;
            float2 _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4;
            SphereMask_float2(_Remap_a750c2c44aae60819e23ba15db6f5073_Out_3, float2(0, 0), _Property_5e8273d56a1f6888ae8cab9fde8e2289_Out_0, _Property_71810e23d8455f83bd9f8350a4441ed0_Out_0, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4);
            float2 _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2;
            Unity_Subtract_float2(_Subtract_0e8f249bc1ef2884ba2a7e0cd7edc2ec_Out_2, _SphereMask_598fc1e37631458e854b8153280ebc87_Out_4, _Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2);
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_R_1 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[0];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2 = _Remap_a3f21e2228984980a092541aa51c717c_Out_3[1];
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_B_3 = 0;
            float _Split_fbb2b0916d685f8b96a73fbd38f2bc30_A_4 = 0;
            float _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2;
            Unity_Step_float(0, _Split_fbb2b0916d685f8b96a73fbd38f2bc30_G_2, _Step_ba7f8fff4dca78888761dd33562aa58f_Out_2);
            float _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1;
            Unity_OneMinus_float(_Step_ba7f8fff4dca78888761dd33562aa58f_Out_2, _OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1);
            float2 _Subtract_59634dc1066ced85bd0410a18146b693_Out_2;
            Unity_Subtract_float2(_Subtract_b7e0e386fe6d908d868adecb0ad00af5_Out_2, (_OneMinus_e404ed729c8cd186b353bd40e9d52f6d_Out_1.xx), _Subtract_59634dc1066ced85bd0410a18146b693_Out_2);
            float4 _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0 = _Color;
            float _Split_3c0effab1cf64b8d87812d0dd598634c_R_1 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[0];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_G_2 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[1];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_B_3 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[2];
            float _Split_3c0effab1cf64b8d87812d0dd598634c_A_4 = _Property_ebe3d9f0ce71f38390be9b6541a1d100_Out_0[3];
            float2 _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2;
            Unity_Multiply_float2_float2(_Subtract_59634dc1066ced85bd0410a18146b693_Out_2, (_Split_3c0effab1cf64b8d87812d0dd598634c_A_4.xx), _Multiply_12cadb24b499138685926e18dcf6a8db_Out_2);
            surface.Alpha = (_Multiply_12cadb24b499138685926e18dcf6a8db_Out_2).x;
            surface.AlphaClipThreshold = 0.01;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.uv0 = input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    CustomEditorForRenderPipeline "UnityEditor.ShaderGraphUnlitGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}