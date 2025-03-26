//
//  ContentView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 2/22/25.
//

import SwiftUI

struct HomeView: View {
    @State private var messages: [String] = []
    @State private var inputText = ""
    @State private var isLoading = false
    @State private var hasStartedChat = false

    var body: some View {
        VStack(spacing: 0) {
            if !hasStartedChat {
                Spacer()

                VStack(spacing: 16) {
                    // 🖼 Your PNG logo from Assets
                    Image("ConvrsLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .opacity(0.9)

                    Text("Welcome to CONVRS")
                        .font(.headline)
                        .foregroundColor(.gray)
                }

                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(messages, id: \.self) { message in
                            Text(message)
                                .padding()
                                .background(message.starts(with: "You:") ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, alignment: message.starts(with: "You:") ? .trailing : .leading)
                        }
                    }
                    .padding()
                }
            }

            if isLoading {
                ProgressView("Thinking...")
                    .padding()
            }

            HStack {
                TextField("Ask your ethical question...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .disabled(isLoading)

                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                }
                .padding()
                .disabled(isLoading || inputText.isEmpty)
            }
            .padding(.bottom)
        }
    }

    func sendMessage() {
        guard !inputText.isEmpty else { return }

        let userMessage = "You: \(inputText)"
        messages.append(userMessage)
        hasStartedChat = true

        let prompt = """
        You will be given an ethical question. Respond with a short answer followed by a brief explanation.

        Question: \(inputText)

        Answer:
        """

        inputText = ""
        isLoading = true

        Task {
            let aiResponse = await fetchHuggingFaceResponse(prompt: prompt)
            DispatchQueue.main.async {
                messages.append("CONVRS: \(aiResponse)")
                isLoading = false
            }
        }
    }

    func fetchHuggingFaceResponse(prompt: String) async -> String {
        guard let url = URL(string: "https://api-inference.huggingface.co/models/tiiuae/falcon-7b-instruct") else {
            return "Invalid API URL"
        }

        let requestBody: [String: Any] = ["inputs": prompt]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return "Failed to encode request"
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // 🔐 Insert your Hugging Face API key here:
        request.setValue("Bearer ***REMOVED***", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let first = jsonArray.first,
               let text = first["generated_text"] as? String {

                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if let answerStart = trimmed.range(of: "Answer:") {
                    let cleaned = trimmed[answerStart.upperBound...].trimmingCharacters(in: .whitespacesAndNewlines)
                    return cleaned
                } else {
                    return trimmed
                }
            }

            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let error = jsonObject["error"] as? String {
                return "API Error: \(error)"
            }

            return "Unexpected response format"
        } catch {
            print("Error: \(error.localizedDescription)")
            return "Error fetching response from Hugging Face"
        }
    }
}
